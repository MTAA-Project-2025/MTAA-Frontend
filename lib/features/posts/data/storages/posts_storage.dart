import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/domain/entities/my_db_context.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/full_post_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

abstract class PostsStorage {
  Future<List<FullPostResponse>> getRecommended();
  Future setRecommended(List<FullPostResponse> posts);

  Future saveSimple(String ownerId, SimplePostResponse post);
  Future<List<SimplePostResponse>> getAccountPosts(String userId, PageParameters pageParameters);
}

class PostsStorageImpl extends PostsStorage {
  final String recommendedPosts = 'recommendedPosts';
  final MyDbContext dbContext;
  final MyImageStorage imageStorage;
  final Dio dio;

  PostsStorageImpl(this.dbContext, this.imageStorage, this.dio);

  @override
  Future<List<FullPostResponse>> getRecommended() async {
    var box = await Hive.openBox<List>(postsDataBox);

    List<dynamic>? posts = box.get(recommendedPosts);

    if (posts == null) return [];

    return posts.map((e) => FullPostResponse.fromHive(e)).toList();
  }

  @override
  Future setRecommended(List<FullPostResponse> posts) async {
    List<FullPostResponse> postsToAddImg = [];
    var postsHive = posts.map((e) => FullPostHive.fromResponse(e)).toList();
    
    var oldPosts = await getRecommended();
    for (var post in oldPosts) {
      if (!posts.any((e) => e.id == post.id && e.isLocal)) {
        for (var imgGroup in post.images) {
          for (var img in imgGroup.images) {
            await imageStorage.deleteImage(img.fullPath);
          }
        }
        postsToAddImg.add(post);
      }
    }
    var box = await Hive.openBox<List>(postsDataBox);

    for (var post in posts) {
      var origPost = postsHive.firstWhere((e) => e.id == post.id.uuid, orElse: () => FullPostHive.fromResponse(post));

      for (var imgGroup in origPost.images) {
        var img = imgGroup.images.firstWhere((e) => e.type == ImageSizeType.middle.index);
        var uint8List = await urlToUint8List(img.fullPath);
        if (uint8List == null) continue;
        var path = await imageStorage.saveTempImage(uint8List, imgGroup.title);
        img.localPath = path;
      }
      if (origPost.owner.avatar != null) {
        for (var img in origPost.owner.avatar!.images) {
          var uint8List = await urlToUint8List(img.fullPath);
          if (uint8List == null) continue;
          var path = await imageStorage.saveTempImage(uint8List, 'avatar');
          img.localPath = path;
        }
      }
    }
    await box.put(recommendedPosts, postsHive);
  }

  //Gpt
  Future<Uint8List?> urlToUint8List(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Failed to load image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<SimplePostResponse>> getAccountPosts(String userId, PageParameters pageParameters) async {
    final postsSubquery = Subquery(
        dbContext.select(dbContext.posts)
          ..where((e) => e.ownerId.equals(userId))
          ..orderBy([(row) => OrderingTerm.desc(row.dataCreationTime)])
          ..limit(pageParameters.pageSize, offset: pageParameters.pageSize * pageParameters.pageNumber),
        's');

    final query = dbContext.select(postsSubquery).join([
      leftOuterJoin(
        dbContext.myImages,
        dbContext.myImages.postId.equalsExp(dbContext.posts.id),
      ),
    ]);

    final rows = await query.get();

    final List<SimplePostResponse> posts = [];

    for (final row in rows) {
      var postTable = row.readTable(dbContext.posts);
      var imageTable = row.readTable(dbContext.myImages);

      var image = MyImageResponse(
          aspectRatio: imageTable.aspectRatio,
          fileType: imageTable.fileType,
          fullPath: imageTable.fullPath,
          height: imageTable.height,
          id: imageTable.id,
          localPath: imageTable.localFullPath,
          shortPath: imageTable.shortPath,
          type: ImageSizeType.values[imageTable.type],
          width: imageTable.width);

      var post = SimplePostResponse(id: UuidValue.fromString(postTable.id), smallFirstImage: image, dataCreationTime: postTable.dataCreationTime, isLocal: true);

      posts.add(post);
    }

    return posts;
  }

  @override
  Future saveSimple(String ownerId, SimplePostResponse post) async {
    final query = dbContext.selectOnly(dbContext.posts)
      ..addColumns([dbContext.posts.id])
      ..where(dbContext.posts.id.equals(post.id.uuid));

    final isPostExist = await query.getSingleOrNull() != null;

    if (isPostExist) {
      return;
    }
    await dbContext.transaction(() async {
      var userId = await TokenStorage.getUserId();

      await dbContext.into(dbContext.posts).insert(PostsCompanion(
            id: Value(post.id.uuid),
            ownerId: Value(ownerId),
            dataCreationTime: Value(post.dataCreationTime),
            currentUser: Value(userId ?? ''),
          ));

      await dbContext.into(dbContext.myImages).insert(MyImagesCompanion(
            id: Value(post.smallFirstImage.id),
            myImageGroupId: Value(post.smallFirstImage.id),
            shortPath: Value(post.smallFirstImage.shortPath),
            fullPath: Value(post.smallFirstImage.fullPath),
            fileType: Value(post.smallFirstImage.fileType),
            height: Value(post.smallFirstImage.height),
            width: Value(post.smallFirstImage.width),
            aspectRatio: Value(post.smallFirstImage.aspectRatio),
            type: Value(post.smallFirstImage.type.index),
            localFullPath: Value(post.smallFirstImage.localPath),
          ));
    });
  }
}
