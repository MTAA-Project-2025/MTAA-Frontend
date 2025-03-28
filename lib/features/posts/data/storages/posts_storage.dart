import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/domain/entities/my_db_context.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_image_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_location_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_post_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/crop_aspect_ratio_preset_custom_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/full_post_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/add_post_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/add_post_form.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:uuid/uuid.dart';

abstract class PostsStorage {
  Future<List<FullPostResponse>> getRecommended();
  Future setRecommended(List<FullPostResponse> posts);

  Future<AddPostHive?> getTempPostAddForm();
  Future setTempPostAddForm(List<AddPostImageScreenDTO> images, List<ImageDTO> imageDTOs, String text, AddLocationRequest? addLocation);
  Future deleteTempPostAddForm();

  Future saveSimple(String ownerId, SimplePostResponse post);
  Future<List<SimplePostResponse>> getAccountPosts(String userId, PageParameters pageParameters);
}

class PostsStorageImpl extends PostsStorage {
  final String recommendedPosts = 'recommendedPosts';
  final String tempAddPost = 'teamAddPost';
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
  Future<AddPostHive?> getTempPostAddForm() async {
    var box = await Hive.openBox<AddPostHive>(tempAddPostDataBox);

    return box.get(tempAddPost);
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
        var uint8List = await imageStorage.urlToUint8List(img.fullPath);
        if (uint8List == null) continue;
        var path = await imageStorage.saveTempImage(uint8List, 'postImg_${imgGroup.title}_${img.id}');
        img.localPath = path;
      }
      if (origPost.owner.avatar != null) {
        for (var img in origPost.owner.avatar!.images) {
          var uint8List = await imageStorage.urlToUint8List(img.fullPath);
          if (uint8List == null) continue;
          var path = await imageStorage.saveTempImage(uint8List, 'recommend_system_avatar_${img.id}');
          img.localPath = path;
        }
      }
    }
    await box.put(recommendedPosts, postsHive);
  }

  @override
  Future deleteTempPostAddForm() async {
    var oldPostForm = await getTempPostAddForm();
    if(oldPostForm!=null){
      for(var img in oldPostForm.images){
        await imageStorage.deleteImage(img.imagePath);
        await imageStorage.deleteImage(img.origImagePath);
      }
    }
    var box = await Hive.openBox<AddPostHive>(tempAddPostDataBox);
    await box.delete(tempAddPost);
  }

  @override
  Future setTempPostAddForm(List<AddPostImageScreenDTO> images, List<ImageDTO> imageDTOs, String text, AddLocationRequest? addLocation) async {
    List<AddImageHive> imagesHive = [];

    for(int i = 0;i<images.length;i++){
      AddImageHive newImageHive = AddImageHive();
      if(images[i].imagePath !=null){
        newImageHive.imagePath = images[i].imagePath!;
      }
      else if(images[i].image!=null){
        newImageHive.imagePath = await imageStorage.saveTempImage(images[i].image!.readAsBytesSync(), 'add_pos_img_$i');
      }

      if(images[i].originalImageLocalPath !=null){
        newImageHive.origImagePath = images[i].originalImageLocalPath!;
      }
      else if(images[i].originalImage!=null){
        newImageHive.origImagePath = await imageStorage.saveTempImage(await images[i].originalImage!.readAsBytes(), 'add_pos_img_orig_$i');
      }
      newImageHive.aspectRatioPreset=CropAspectRatioPresetCustomHive.fromRequest(imageDTOs[i].aspectRatioPreset);
      newImageHive.isAspectRatioError=imageDTOs[i].isAspectRatioError;
      newImageHive.position = images[i].position;

      imagesHive.add(newImageHive);
    }
    
    var hivePost = AddPostHive(images: imagesHive,
    location: addLocation!=null?AddLocationHive.fromRequest(addLocation):null,
    description: text);
    
    var box = await Hive.openBox<AddPostHive>(tempAddPostDataBox);
    await box.put(tempAddPost, hivePost);
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
