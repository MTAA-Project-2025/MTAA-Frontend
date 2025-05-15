import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/domain/entities/my_db_context.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_image_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_location_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_post_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/crop_aspect_ratio_preset_custom_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/full_post_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/requests/add_image_request.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/location_point_type.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/notifications/data/network/phoneNotificationService.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/add_post_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/schedule_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/add_post_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/add_post_form.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/synchronization/data/version_post_item_response.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:uuid/uuid.dart';

abstract class PostsStorage {
  Future<List<FullPostResponse>> getRecommended();
  Future setRecommended(List<FullPostResponse> posts);

  Future<AddPostHive?> getTempPostAddForm();
  Future setTempPostAddForm(List<AddPostImageScreenDTO> images, List<ImageDTO> imageDTOs, String text, AddLocationRequest? addLocation);
  Future deleteTempPostAddForm();

  Future saveLocationPost(LocationPostResponse post);
  Future removeLocationPost(LocationPostResponse post);
  Future<List<LocationPostResponse>> getSavedLocationPosts(PageParameters pageParameteres);
  Future<LocationPostResponse?> getSavedLocationPostById(UuidValue id);
  Future<bool> isLocationPostSaved(UuidValue postId);

  Future saveSimple(SimplePostResponse post, int version);
  Future<DateTime?> getSimplePostDateTime(UuidValue id);
  Future<List<SimplePostResponse>> getAccountPosts(PageParameters pageParameters);

  Future<List<VersionPostItemResponse>> getVersionPostItems(PageParameters pageParameters);
  Future<List<VersionPostItemResponse>> getVersionScheduledPostItems(PageParameters pageParameters);
  Future<int> updatePost(FullPostResponse newPost, LocationPostResponse? locationPost, int newVersion);
  Future deletePost(UuidValue id);

  Future saveSchedulePost(SchedulePostResponse post);
  Future removeSchedulePost(SchedulePostResponse post);
  Future<List<SchedulePostResponse>> getSavedSchedulePosts(PageParameters pageParameteres);
  Future<SchedulePostResponse?> getSavedSchedulePostById(UuidValue id);
  Future<int> updateSchedulePost(SchedulePostResponse newPost, int newVersion);

  Future setScheduledPostsHive(List<AddPostRequest> requests);
  Future<List<AddPostRequest>> getScheduledPostsHive();
}

class PostsStorageImpl extends PostsStorage {
  final String recommendedPosts = 'recommendedPosts';
  final String scheduledPosts = 'scheduledPosts';
  final String tempAddPost = 'teamAddPost';
  final MyDbContext dbContext;
  final MyImageStorage imageStorage;
  final Dio dio;
  final PhoneNotificationsService notificationsService;
  final TokenStorage tokenStorage;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  PostsStorageImpl(this.dbContext, this.imageStorage, this.dio, this.notificationsService, this.tokenStorage);

  @override
  Future<List<FullPostResponse>> getRecommended() async {
    var box = await Hive.openBox<List>(postsDataBox);

    List<dynamic>? posts = box.get(recommendedPosts);

    if (posts == null) return [];

    return posts.map((e) => FullPostResponse.fromHive(e)).toList();
  }

  Future<List<FullPostHive>> getRecommendedOrig() async {
    var box = await Hive.openBox<List>(postsDataBox);

    List<dynamic>? posts = box.get(recommendedPosts);

    if (posts == null) return [];

    return posts.map((e) => e as FullPostHive).toList();
  }

  @override
  Future<AddPostHive?> getTempPostAddForm() async {
    var box = await Hive.openBox<AddPostHive>(tempAddPostDataBox);

    var res = box.get(tempAddPost);
    if (res != null) {
      await analytics.logEvent(name: 'get_temp_post_add_form', parameters: {
        'box': tempAddPostDataBox,
        'key': tempAddPost,
      });
    }
    return res;
  }

  @override
  Future setRecommended(List<FullPostResponse> posts) async {
    List<FullPostHive> postsToAddImg = [];
    List<FullPostHive> postsToAdd = [];

    var oldPosts = await getRecommendedOrig();
    for (var post in oldPosts) {
      if (!posts.any((e) => e.id.uuid == post.id)) {
        for (var imgGroup in post.images) {
          for (var img in imgGroup.images) {
            await imageStorage.deleteImage(img.fullPath);
          }
        }
      }
    }

    for (var post in posts) {
      if (oldPosts.any((e) => e.id == post.id.uuid)) {
        var res = oldPosts.firstWhere((e) => e.id == post.id.uuid);
        postsToAdd.add(res);
      } else {
        var hive = FullPostHive.fromResponse(post);
        postsToAdd.add(hive);
        postsToAddImg.add(hive);
      }
    }
    var box = await Hive.openBox<List>(postsDataBox);

    for (var post in postsToAddImg) {
      for (var imgGroup in post.images) {
        var img = imgGroup.images.firstWhere((e) => e.type == ImageSizeType.large.index);
        var uint8List = await imageStorage.urlToUint8List(img.fullPath);
        if (uint8List == null) continue;
        var path = await imageStorage.saveTempImage(uint8List, 'postImg_${imgGroup.title}_${img.id}');
        img.localPath = path;
      }
      if (post.owner.avatar != null) {
        for (var img in post.owner.avatar!.images) {
          var uint8List = await imageStorage.urlToUint8List(img.fullPath);
          if (uint8List == null) continue;
          var path = await imageStorage.saveTempImage(uint8List, 'recommend_system_avatar_${img.id}');
          img.localPath = path;
        }
      }
    }
    await box.put(recommendedPosts, postsToAdd);
  }

  @override
  Future deleteTempPostAddForm() async {
    var oldPostForm = await getTempPostAddForm();
    if (oldPostForm != null) {
      for (var img in oldPostForm.images) {
        await imageStorage.deleteImage(img.imagePath);
        await imageStorage.deleteImage(img.origImagePath);
      }
    }
    var box = await Hive.openBox<AddPostHive>(tempAddPostDataBox);

    await analytics.logEvent(name: 'delete_temp_post_add_form', parameters: {
      'box': tempAddPostDataBox,
      'key': tempAddPost,
    });

    await box.delete(tempAddPost);
  }

  @override
  Future setTempPostAddForm(List<AddPostImageScreenDTO> images, List<ImageDTO> imageDTOs, String text, AddLocationRequest? addLocation) async {
    List<AddImageHive> imagesHive = [];

    for (int i = 0; i < images.length; i++) {
      AddImageHive newImageHive = AddImageHive();
      if (images[i].imagePath != null) {
        newImageHive.imagePath = images[i].imagePath!;
      } else if (images[i].image != null) {
        newImageHive.imagePath = await imageStorage.saveTempImage(images[i].image!.readAsBytesSync(), 'add_pos_img_$i');
      }

      if (images[i].originalImageLocalPath != null) {
        newImageHive.origImagePath = images[i].originalImageLocalPath!;
      } else if (images[i].originalImage != null) {
        newImageHive.origImagePath = await imageStorage.saveTempImage(await images[i].originalImage!.readAsBytes(), 'add_pos_img_orig_$i');
      }
      newImageHive.aspectRatioPreset = CropAspectRatioPresetCustomHive.fromRequest(imageDTOs[i].aspectRatioPreset);
      newImageHive.isAspectRatioError = imageDTOs[i].isAspectRatioError;
      newImageHive.position = images[i].position;

      imagesHive.add(newImageHive);
    }

    var hivePost = AddPostHive(images: imagesHive, location: addLocation != null ? AddLocationHive.fromRequest(addLocation) : null, description: text, id: Uuid().v4());

    var box = await Hive.openBox<AddPostHive>(tempAddPostDataBox);
    await box.put(tempAddPost, hivePost);
  }

  @override
  Future<List<AddPostRequest>> getScheduledPostsHive() async {
    var box = await Hive.openBox<List>(scheduledAddPostDataBox);
    List<dynamic>? oldPosts = box.get(scheduledPosts);

    if (oldPosts == null) return [];
    var mappedPosts = oldPosts.map((e) => e as AddPostHive).toList();

    List<AddPostRequest> res = [];

    for (var post in mappedPosts) {
      List<AddImageRequest> images = [];
      for (var img in post.images) {
        File imageFile = File(img.imagePath);
        AddImageRequest newImage = AddImageRequest(image: imageFile, position: img.position);
        images.add(newImage);
      }
      var request =
          AddPostRequest(images: images, description: post.description, location: post.location != null ? AddLocationRequest.fromHive(post.location!) : null, scheduledDate: post.scheduledDate);
      request.id = UuidValue.fromString(post.id);
      res.add(request);
    }
    return res;
  }

  @override
  Future setScheduledPostsHive(List<AddPostRequest> requests) async {
    var box = await Hive.openBox<List>(scheduledAddPostDataBox);
    List<dynamic>? oldPosts = box.get(scheduledPosts);

    if (oldPosts == null) return [];
    var mappedPosts = oldPosts.map((e) => e as AddPostHive).toList();

    await analytics.logEvent(name: 'set_scheduled_posts_hive', parameters: {'box': scheduledAddPostDataBox, 'key': scheduledPosts, 'count': requests.length});

    List<AddPostRequest> postsToAdd = [];
    List<AddPostHive> hivePosts = [];

    for (var post in mappedPosts) {
      if (!requests.any((e) => e.id!.uuid == post.id)) {
        for (var img in post.images) {
          await imageStorage.deleteImage(img.imagePath);
        }
      }
    }
    for (var request in requests) {
      if (mappedPosts.any((e) => e.id == request.id!.uuid)) {
        var res = mappedPosts.firstWhere((e) => e.id == request.id!.uuid);
        hivePosts.add(res);
      } else {
        postsToAdd.add(request);
      }
    }

    for (var request in requests) {
      List<AddImageHive> imagesHive = [];
      for (int j = 0; j < request.images.length; j++) {
        AddImageHive newImageHive = AddImageHive();
        newImageHive.imagePath = await imageStorage.saveTempImage(request.images[j].image.readAsBytesSync(), '${request.id!.uuid}_add_pos_img_$j');
        newImageHive.origImagePath = '';
        newImageHive.aspectRatioPreset = CropAspectRatioPresetCustomHive(height: 0, width: 0);
        newImageHive.isAspectRatioError = false;
        newImageHive.position = request.images[j].position;

        imagesHive.add(newImageHive);
      }
      hivePosts
          .add(AddPostHive(images: imagesHive, location: request.location != null ? AddLocationHive.fromRequest(request.location!) : null, description: request.description, id: request.id!.uuid));
    }
    await box.put(scheduledAddPostDataBox, hivePosts);
  }

  @override
  Future<List<SimplePostResponse>> getAccountPosts(PageParameters pageParameters) async {
    final postsSubquery = dbContext.selectOnly(dbContext.posts)
      ..addColumns([dbContext.posts.id])
      ..orderBy([OrderingTerm.desc(dbContext.posts.dataCreationTime)])
      ..limit(pageParameters.pageSize, offset: pageParameters.pageSize * pageParameters.pageNumber);

    final postIds = await postsSubquery.map((row) => row.read(dbContext.posts.id)).get();

    if (postIds.isEmpty) {
      return [];
    }

    final query = dbContext.select(dbContext.posts).join([
      leftOuterJoin(
        dbContext.myImages,
        dbContext.myImages.postId.equalsExp(dbContext.posts.id),
      ),
    ])
      ..where(dbContext.posts.id.isIn(postIds.cast<String>()));

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

      if(posts.any((e)=>e.id.uuid==postTable.id))continue;
      var post = SimplePostResponse(id: UuidValue.fromString(postTable.id), smallFirstImage: image, dataCreationTime: postTable.dataCreationTime, isLocal: true);

      posts.add(post);
    }

    return posts..sort((a, b) => b.dataCreationTime.compareTo(a.dataCreationTime));
  }

  @override
  Future<List<VersionPostItemResponse>> getVersionPostItems(PageParameters pageParameters) async {
    final posts = await dbContext.select(dbContext.posts).get();

    return posts
        .map((post) => VersionPostItemResponse(
              id: UuidValue.fromString(post.id),
              version: post.version,
            ))
        .toList();
  }

  @override
  Future<List<VersionPostItemResponse>> getVersionScheduledPostItems(PageParameters pageParameters) async {
    final posts = await dbContext.select(dbContext.schedulePosts).get();

    return posts
        .map((post) => VersionPostItemResponse(
              id: UuidValue.fromString(post.id),
              version: post.version,
            ))
        .toList();
  }

  @override
  Future<int> updatePost(FullPostResponse newPost, LocationPostResponse? locationPost, int newVersion) async {
    await analytics.logEvent(name: 'update_post_locally', parameters: {
      'newVersion': newVersion,
    });

    final oldPost = await (dbContext.select(dbContext.posts)..where((tbl) => tbl.id.equals(newPost.id.uuid))).getSingleOrNull();

    if (oldPost == null) {
      MyImageResponse firstImage = newPost.images.first.images.firstWhere((img) => img.type == ImageSizeType.small);

      await saveSimple(SimplePostResponse(id: newPost.id, smallFirstImage: firstImage, dataCreationTime: newPost.dataCreationTime), newVersion);
      return newVersion;
    }

    final oldImages = await (dbContext.select(dbContext.myImages)..where((tbl) => tbl.postId.equals(newPost.id.uuid))).get();

    final List<MyImage> newImages = newPost.images.map((img) {
      var image = img.images.firstWhere((img) => img.type == ImageSizeType.small);

      return MyImage(
          id: image.id,
          shortPath: image.shortPath,
          fullPath: image.fullPath,
          localFullPath: '',
          fileType: image.fileType,
          height: image.height,
          width: image.width,
          aspectRatio: image.aspectRatio,
          type: image.type.index,
          postId: newPost.id.uuid);
    }).toList();

    final List<MyImage> imagesToAdd = [];
    final List<MyImage> imagesToDelete = [];

    int oldVersion = oldPost.version;

    final oldImageIds = oldImages.map((e) => e.id).toSet();
    final newImageIds = newImages.map((e) => e.id).toSet();

    final addedImageIds = newImageIds.difference(oldImageIds);
    final removedImageIds = oldImageIds.difference(newImageIds);

    for (final id in addedImageIds) {
      final image = newImages.firstWhere((img) => img.id == id);
      imagesToAdd.add(image);
    }

    for (final id in removedImageIds) {
      final image = oldImages.firstWhere((img) => img.id == id);

      if (image.locationPostId != null || image.simpleLocationPointId != null || image.schedulePostId != null) {
        await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(image.id))).write(MyImagesCompanion(
          postId: const Value(null),
        ));
      } else {
        MyImage img = MyImage(
            id: image.id,
            shortPath: image.shortPath,
            fullPath: image.fullPath,
            localFullPath: image.localFullPath,
            fileType: image.fileType,
            height: image.height,
            width: image.width,
            aspectRatio: image.aspectRatio,
            type: image.type);
        imagesToDelete.add(img);
      }
    }

    for (final image in imagesToAdd) {
      var uint8List = await imageStorage.urlToUint8List(image.fullPath);
      if (uint8List == null) continue;
      var path = await imageStorage.saveTempImage(uint8List, 'simplepostImg_${image.id}');
      MyImage img = MyImage(
          id: image.id,
          shortPath: image.shortPath,
          fullPath: image.fullPath,
          localFullPath: path,
          fileType: image.fileType,
          height: image.height,
          width: image.width,
          aspectRatio: image.aspectRatio,
          type: image.type);
      await dbContext.into(dbContext.myImages).insert(img);
    }

    for (final image in imagesToDelete) {
      await imageStorage.deleteImage(image.localFullPath);
      await (dbContext.delete(dbContext.myImages)..where((tbl) => tbl.id.equals(image.id))).go();
    }

    final oldLocationPost = await (dbContext.select(dbContext.locationPosts)..where((tbl) => tbl.id.equals(newPost.id.uuid))).getSingleOrNull();
    if (oldLocationPost != null) {
      bool locationPostNeedsUpdate = false;
      if (oldLocationPost.description != newPost.description ||
          oldLocationPost.eventTime != locationPost!.eventTime ||
          oldLocationPost.ownerDisplayName != locationPost.ownerDisplayName ||
          oldLocationPost.smallFirstImageId != locationPost.smallFirstImage.id ||
          oldLocationPost.pointId != locationPost.point.id.uuid) {
        locationPostNeedsUpdate = true;
      }

      if (locationPostNeedsUpdate) {
        await (dbContext.update(dbContext.locationPosts)..where((tbl) => tbl.id.equals(oldLocationPost.id))).write(LocationPostsCompanion(
          description: Value(newPost.description),
          eventTime: Value(locationPost!.eventTime),
          ownerDisplayName: Value(locationPost.ownerDisplayName),
          smallFirstImageId: Value(locationPost.smallFirstImage.id),
          version: Value(newVersion),
        ));
      }
    }

    await (dbContext.update(dbContext.posts)..where((tbl) => tbl.id.equals(oldPost.id))).write(PostsCompanion(
      version: Value(newVersion),
    ));

    for (var image in imagesToAdd) {
      await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(image.id))).write(MyImagesCompanion(
        postId: Value(newPost.id.uuid),
      ));
    }

    return newVersion - oldVersion;
  }

  @override
  Future<int> updateSchedulePost(SchedulePostResponse newPost, int newVersion) async {
    await analytics.logEvent(name: 'update_scheduled_post_locally', parameters: {
      'newVersion': newVersion,
    });
    final oldPost = await (dbContext.select(dbContext.schedulePosts)..where((tbl) => tbl.id.equals(newPost.id.uuid))).getSingleOrNull();

    if (oldPost == null) {
      await saveSchedulePost(newPost);
      return newVersion;
    }

    final oldImage = await (dbContext.select(dbContext.myImages)..where((tbl) => tbl.id.equals(oldPost.smallFirstImageId))).getSingleOrNull();

    if (oldImage != null && oldImage.id != newPost.smallFirstImage.id && oldImage.postId == null && oldImage.locationPostId == null && oldImage.simpleLocationPointId == null) {
      await imageStorage.deleteImage(oldImage.localFullPath);
      await (dbContext.delete(dbContext.myImages)..where((tbl) => tbl.id.equals(oldImage.id))).go();
    } else if (oldImage != null) {
      await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(oldImage.id))).write(MyImagesCompanion(
        schedulePostId: Value(null),
      ));
    }

    if (oldImage != null && oldImage.id != newPost.smallFirstImage.id) {
      await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(newPost.smallFirstImage.id))).write(MyImagesCompanion(
        schedulePostId: Value(newPost.id.uuid),
      ));
    }
    await (dbContext.update(dbContext.schedulePosts)..where((tbl) => tbl.id.equals(oldPost.id))).write(SchedulePostsCompanion(
      description: Value(newPost.description),
      dataCreationTime: Value(newPost.dataCreationTime),
      smallFirstImageId: Value(newPost.smallFirstImage.id),
      isHidden: Value(newPost.isHidden),
      hiddenReason: Value(newPost.hiddenReason),
      schedulePublishDate: Value(newPost.schedulePublishDate),
      version: Value(newVersion),
    ));
    return newVersion - oldPost.version;
  }

  @override
  Future saveSchedulePost(SchedulePostResponse post) async {
    await analytics.logEvent(name: 'save_scheduled_post_locally', parameters: {'postId': post.id.uuid});
    final query = dbContext.selectOnly(dbContext.schedulePosts)
      ..addColumns([dbContext.schedulePosts.id])
      ..where(dbContext.schedulePosts.id.equals(post.id.uuid));

    final isPostExist = await query.getSingleOrNull() != null;
    if (isPostExist) {
      return;
    }

    final imageExists = await (dbContext.select(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).getSingleOrNull();

    if (imageExists == null && post.smallFirstImage.localPath == '') {
      var uint8List = await imageStorage.urlToUint8List(post.smallFirstImage.fullPath);
      if (uint8List != null) {
        var path = await imageStorage.saveTempImage(
          uint8List,
          'postScheduleImg_${post.smallFirstImage.type.index}_${post.smallFirstImage.id}',
        );
        post.smallFirstImage.localPath = path;
      }
    }

    await dbContext.transaction(() async {
      await dbContext.into(dbContext.schedulePosts).insert(SchedulePostsCompanion(
            id: Value(post.id.uuid),
            description: Value(post.description),
            dataCreationTime: Value(post.dataCreationTime),
            smallFirstImageId: Value(post.smallFirstImage.id),
            version: Value(post.version),
            isHidden: Value(post.isHidden),
            hiddenReason: Value(post.hiddenReason),
            schedulePublishDate: Value(post.schedulePublishDate),
          ));

      if (imageExists == null) {
        await dbContext.into(dbContext.myImages).insert(MyImagesCompanion(
              id: Value(post.smallFirstImage.id),
              shortPath: Value(post.smallFirstImage.shortPath),
              fullPath: Value(post.smallFirstImage.fullPath),
              fileType: Value(post.smallFirstImage.fileType),
              height: Value(post.smallFirstImage.height),
              width: Value(post.smallFirstImage.width),
              aspectRatio: Value(post.smallFirstImage.aspectRatio),
              type: Value(post.smallFirstImage.type.index),
              localFullPath: Value(post.smallFirstImage.localPath),
              schedulePostId: Value(post.id.uuid),
            ));
      } else {
        await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).write(MyImagesCompanion(
          schedulePostId: Value(post.id.uuid),
        ));
      }
    });
  }

  @override
  Future removeSchedulePost(SchedulePostResponse post) async {
    await analytics.logEvent(name: 'remove_scheduled_post_locally', parameters: {'postId': post.id.uuid});

    final query = dbContext.selectOnly(dbContext.schedulePosts)
      ..addColumns([dbContext.schedulePosts.id])
      ..where(dbContext.schedulePosts.id.equals(post.id.uuid));
    final isPostExist = await query.getSingleOrNull();
    if (isPostExist == null) {
      return;
    }

    final imageExists = await (dbContext.select(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).getSingleOrNull();

    if (imageExists != null && imageExists.postId == null && imageExists.locationPostId == null) {
      await imageStorage.deleteImage(post.smallFirstImage.localPath);
    }

    await dbContext.transaction(() async {
      await dbContext.delete(dbContext.schedulePosts).delete(SchedulePostsCompanion(id: Value(post.id.uuid)));

      if (imageExists != null && imageExists.postId == null && imageExists.locationPostId == null) {
        await dbContext.delete(dbContext.myImages).delete(MyImagesCompanion(id: Value(post.smallFirstImage.id)));
      } else {
        await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).write(MyImagesCompanion(
          schedulePostId: Value(null),
        ));
      }
    });
  }

  @override
  Future<List<SchedulePostResponse>> getSavedSchedulePosts(PageParameters pageParameteres) async {
    final postsSubquery = dbContext.selectOnly(dbContext.schedulePosts)
      ..addColumns([dbContext.schedulePosts.id])
      ..orderBy([OrderingTerm.desc(dbContext.schedulePosts.dataCreationTime)])
      ..limit(pageParameteres.pageSize, offset: pageParameteres.pageSize * pageParameteres.pageNumber);

    final postIds = await postsSubquery.map((row) => row.read(dbContext.schedulePosts.id)).get();

    if (postIds.isEmpty) {
      return [];
    }

    final query = dbContext.select(dbContext.schedulePosts).join([
      leftOuterJoin(
        dbContext.myImages,
        dbContext.myImages.schedulePostId.equalsExp(dbContext.schedulePosts.id),
      ),
    ])
      ..where(dbContext.schedulePosts.id.isIn(postIds.cast<String>()));

    final rows = await query.get();

    final List<SchedulePostResponse> posts = [];

    for (final row in rows) {
      var postTable = row.readTable(dbContext.schedulePosts);
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

      var post = SchedulePostResponse(
        id: UuidValue.fromString(postTable.id),
        smallFirstImage: image,
        dataCreationTime: postTable.dataCreationTime,
        description: postTable.description,
        isLocal: true,
        isHidden: postTable.isHidden,
        hiddenReason: postTable.hiddenReason,
        schedulePublishDate: postTable.schedulePublishDate,
        version: postTable.version,
      );

      posts.add(post);
    }

    return posts;
  }

  @override
  Future<SchedulePostResponse?> getSavedSchedulePostById(UuidValue id) async {
    final query = dbContext.select(dbContext.schedulePosts).join([
      leftOuterJoin(
        dbContext.myImages,
        dbContext.myImages.schedulePostId.equalsExp(dbContext.schedulePosts.id),
      ),
    ])
      ..where(dbContext.schedulePosts.id.equals(id.uuid));

    final rows = await query.getSingleOrNull();

    if (rows == null) {
      return null;
    }

    var postTable = rows.readTable(dbContext.schedulePosts);
    var imageTable = rows.readTable(dbContext.myImages);

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

    return SchedulePostResponse(
      id: UuidValue.fromString(postTable.id),
      smallFirstImage: image,
      dataCreationTime: postTable.dataCreationTime,
      description: postTable.description,
      isHidden: postTable.isHidden,
      hiddenReason: postTable.hiddenReason,
      schedulePublishDate: postTable.schedulePublishDate,
      version: postTable.version,
      isLocal: true,
    );
  }

  @override
  Future saveLocationPost(LocationPostResponse post) async {
    await analytics.logEvent(name: 'save_location_post_locally', parameters: {'postId': post.id.uuid});
    final query = dbContext.selectOnly(dbContext.locationPosts)
      ..addColumns([dbContext.locationPosts.id])
      ..where(dbContext.locationPosts.id.equals(post.id.uuid));

    final isPostExist = await query.getSingleOrNull() != null;
    if (isPostExist) {
      return;
    }

    final imageExists = await (dbContext.select(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).getSingleOrNull();

    if (imageExists == null && post.smallFirstImage.localPath == '') {
      var uint8List = await imageStorage.urlToUint8List(post.smallFirstImage.fullPath);
      if (uint8List != null) {
        var path = await imageStorage.saveTempImage(
          uint8List,
          'postLocationImg_${post.smallFirstImage.type.index}_${post.smallFirstImage.id}',
        );
        post.smallFirstImage.localPath = path;
      }
    }
    int locationId = await notificationsService.scheduleNotification("One hour to event", post.description, post.eventTime);

    await dbContext.transaction(() async {
      var userId = await tokenStorage.getUserId();

      await dbContext.into(dbContext.locationPosts).insert(LocationPostsCompanion(
            id: Value(post.id.uuid),
            locationId: Value(post.locationId?.uuid),
            eventTime: Value(post.eventTime),
            description: Value(post.description),
            ownerDisplayName: Value(post.ownerDisplayName),
            pointId: Value(post.point.id.uuid),
            dataCreationTime: Value(post.dataCreationTime),
            smallFirstImageId: Value(post.smallFirstImage.id),
            version: Value(0),
            notificationId: Value(locationId),
          ));

      await dbContext.into(dbContext.simpleLocationPoints).insert(SimpleLocationPointsCompanion(
            id: Value(post.point.id.uuid),
            postId: Value(post.id.uuid),
            longitude: Value(post.point.longitude),
            latitude: Value(post.point.latitude),
            type: Value(post.point.type.index),
            zoomLevel: Value(post.point.zoomLevel),
            childCount: Value(post.point.childCount),
            currentUser: Value(userId ?? ''),
          ));

      if (imageExists == null) {
        await dbContext.into(dbContext.myImages).insert(MyImagesCompanion(
              id: Value(post.smallFirstImage.id),
              shortPath: Value(post.smallFirstImage.shortPath),
              fullPath: Value(post.smallFirstImage.fullPath),
              fileType: Value(post.smallFirstImage.fileType),
              height: Value(post.smallFirstImage.height),
              width: Value(post.smallFirstImage.width),
              aspectRatio: Value(post.smallFirstImage.aspectRatio),
              type: Value(post.smallFirstImage.type.index),
              localFullPath: Value(post.smallFirstImage.localPath),
              locationPostId: Value(post.id.uuid),
            ));
      } else {
        await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).write(MyImagesCompanion(
          locationPostId: Value(post.id.uuid),
        ));
      }
    });
  }

  @override
  Future removeLocationPost(LocationPostResponse post) async {
    await analytics.logEvent(name: 'remove_location_post_locally', parameters: {'postId': post.id.uuid});
    final query = dbContext.selectOnly(dbContext.locationPosts)
      ..addColumns([dbContext.locationPosts.id])
      ..addColumns([dbContext.locationPosts.notificationId])
      ..where(dbContext.locationPosts.id.equals(post.id.uuid));
    final isPostExist = await query.getSingleOrNull();
    if (isPostExist == null) {
      return;
    }

    final imageExists = await (dbContext.select(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).getSingleOrNull();

    if (imageExists != null && imageExists.postId == null && imageExists.schedulePostId == null) {
      await imageStorage.deleteImage(post.smallFirstImage.localPath);
    }

    await notificationsService.removeNotification(isPostExist.read(dbContext.locationPosts.notificationId)!);

    await dbContext.transaction(() async {
      await dbContext.delete(dbContext.locationPosts).delete(LocationPostsCompanion(id: Value(post.id.uuid)));
      await dbContext.delete(dbContext.simpleLocationPoints).delete(SimpleLocationPointsCompanion(id: Value(post.point.id.uuid)));

      if (imageExists != null && imageExists.postId == null && imageExists.schedulePostId == null) {
        await dbContext.delete(dbContext.myImages).delete(MyImagesCompanion(id: Value(post.smallFirstImage.id)));
      } else {
        await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).write(MyImagesCompanion(
          locationPostId: Value(null),
        ));
      }
    });
  }

  @override
  Future<List<LocationPostResponse>> getSavedLocationPosts(PageParameters pageParameteres) async {
    final postsSubquery = dbContext.selectOnly(dbContext.locationPosts)
      ..addColumns([dbContext.locationPosts.id])
      ..orderBy([OrderingTerm.desc(dbContext.locationPosts.dataCreationTime)])
      ..limit(pageParameteres.pageSize, offset: pageParameteres.pageSize * pageParameteres.pageNumber);

    final postIds = await postsSubquery.map((row) => row.read(dbContext.locationPosts.id)).get();

    if (postIds.isEmpty) {
      return [];
    }

    final query = dbContext.select(dbContext.locationPosts).join([
      leftOuterJoin(
        dbContext.simpleLocationPoints,
        dbContext.simpleLocationPoints.postId.equalsExp(dbContext.locationPosts.id),
      ),
      leftOuterJoin(
        dbContext.myImages,
        dbContext.myImages.locationPostId.equalsExp(dbContext.locationPosts.id),
      ),
    ])
      ..where(dbContext.locationPosts.id.isIn(postIds.cast<String>()));

    final rows = await query.get();

    final List<LocationPostResponse> posts = [];

    for (final row in rows) {
      var postTable = row.readTable(dbContext.locationPosts);
      var pointTable = row.readTable(dbContext.simpleLocationPoints);
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

      var point = SimpleLocationPointResponse(
        id: UuidValue.fromString(pointTable.id),
        longitude: pointTable.longitude,
        latitude: pointTable.latitude,
        type: LocationPointType.values[pointTable.type],
        zoomLevel: pointTable.zoomLevel,
        childCount: pointTable.childCount,
        image: image,
      );

      var post = LocationPostResponse(
          id: UuidValue.fromString(postTable.id),
          smallFirstImage: image,
          dataCreationTime: postTable.dataCreationTime,
          locationId: UuidValue.fromString(postTable.locationId ?? ''),
          eventTime: postTable.eventTime,
          point: point,
          description: postTable.description,
          ownerDisplayName: postTable.ownerDisplayName,
          isLocal: true);

      posts.add(post);
    }

    return posts;
  }

  @override
  Future<LocationPostResponse?> getSavedLocationPostById(UuidValue id) async {
    final query = dbContext.select(dbContext.locationPosts).join([
      leftOuterJoin(
        dbContext.simpleLocationPoints,
        dbContext.simpleLocationPoints.postId.equalsExp(dbContext.locationPosts.id),
      ),
      leftOuterJoin(
        dbContext.myImages,
        dbContext.myImages.locationPostId.equalsExp(dbContext.locationPosts.id),
      ),
    ])
      ..where(dbContext.locationPosts.id.equals(id.uuid));

    final rows = await query.getSingleOrNull();

    if (rows == null) {
      return null;
    }

    var postTable = rows.readTable(dbContext.locationPosts);
    var pointTable = rows.readTable(dbContext.simpleLocationPoints);
    var imageTable = rows.readTable(dbContext.myImages);

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

    var point = SimpleLocationPointResponse(
      id: UuidValue.fromString(pointTable.id),
      longitude: pointTable.longitude,
      latitude: pointTable.latitude,
      type: LocationPointType.values[pointTable.type],
      zoomLevel: pointTable.zoomLevel,
      childCount: pointTable.childCount,
    );

    return LocationPostResponse(
      id: UuidValue.fromString(postTable.id),
      smallFirstImage: image,
      dataCreationTime: postTable.dataCreationTime,
      locationId: UuidValue.fromString(postTable.locationId ?? ''),
      eventTime: postTable.eventTime,
      point: point,
      description: postTable.description,
      ownerDisplayName: postTable.ownerDisplayName,
    );
  }

  @override
  Future<bool> isLocationPostSaved(UuidValue postId) async {
    final query = dbContext.selectOnly(dbContext.locationPosts)
      ..addColumns([dbContext.locationPosts.id])
      ..where(dbContext.locationPosts.id.equals(postId.uuid));

    return await query.getSingleOrNull() != null;
  }

  @override
  Future saveSimple(SimplePostResponse post, int version) async {
    await analytics.logEvent(name: 'save_simple_post_locally', parameters: {'postId': post.id.uuid});
    final query = dbContext.selectOnly(dbContext.posts)
      ..addColumns([dbContext.posts.id])
      ..where(dbContext.posts.id.equals(post.id.uuid));

    final isPostExist = await query.getSingleOrNull() != null;

    if (isPostExist) {
      return;
    }

    final imageExists = await (dbContext.select(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).getSingleOrNull();

    if (imageExists == null && post.smallFirstImage.localPath == '') {
      var uint8List = await imageStorage.urlToUint8List(post.smallFirstImage.fullPath);
      if (uint8List != null) {
        var path = await imageStorage.saveTempImage(
          uint8List,
          'postSimpleImg_${post.smallFirstImage.type.index}_${post.smallFirstImage.id}',
        );
        post.smallFirstImage.localPath = path;
      }
    }

    final String? ownerId = await tokenStorage.getUserId();
    if (ownerId == null) return;

    await dbContext.transaction(() async {
      await dbContext.into(dbContext.posts).insert(PostsCompanion(
            id: Value(post.id.uuid),
            ownerId: Value(ownerId),
            dataCreationTime: Value(post.dataCreationTime),
            version: Value(version),
          ));

      if (imageExists == null) {
        await dbContext.into(dbContext.myImages).insert(MyImagesCompanion(
              id: Value(post.smallFirstImage.id),
              shortPath: Value(post.smallFirstImage.shortPath),
              fullPath: Value(post.smallFirstImage.fullPath),
              fileType: Value(post.smallFirstImage.fileType),
              height: Value(post.smallFirstImage.height),
              width: Value(post.smallFirstImage.width),
              aspectRatio: Value(post.smallFirstImage.aspectRatio),
              type: Value(post.smallFirstImage.type.index),
              localFullPath: Value(post.smallFirstImage.localPath),
              postId: Value(post.id.uuid),
            ));
      } else {
        await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(post.smallFirstImage.id))).write(MyImagesCompanion(
          postId: Value(post.id.uuid),
        ));
      }
    });
  }

  @override
  Future deletePost(UuidValue id) async {
    await analytics.logEvent(name: 'remove_simple_post_locally', parameters: {'postId': id.uuid});
    final query = dbContext.select(dbContext.posts)..where((e) => dbContext.posts.id.equals(id.uuid));

    final row = await query.getSingleOrNull();

    if (row == null) {
      return null;
    }

    final query2 = dbContext.select(dbContext.posts).join([
      leftOuterJoin(
        dbContext.myImages,
        dbContext.myImages.postId.equalsExp(dbContext.posts.id),
      ),
    ])
      ..where(dbContext.posts.id.equals(row.id));

    final rows = await query2.getSingleOrNull();
    if (rows == null) return null;
    var image = rows.readTableOrNull(dbContext.myImages);

    if (image != null && image.locationPostId == null && image.schedulePostId == null) {
      await imageStorage.deleteImage(image.localFullPath);
    }

    await dbContext.transaction(() async {
      await dbContext.delete(dbContext.posts).delete(PostsCompanion(id: Value(id.uuid)));

      if (image != null && image.locationPostId == null) {
        await dbContext.delete(dbContext.myImages).delete(MyImagesCompanion(id: Value(image.id)));
      } else if (image != null) {
        await (dbContext.update(dbContext.myImages)..where((tbl) => tbl.id.equals(image.id))).write(MyImagesCompanion(
          postId: Value(null),
        ));
      }
    });
    if (image != null && image.locationPostId != null && image.schedulePostId == null) {
      var locPost = await getSavedLocationPostById(UuidValue.fromString(image.locationPostId!));
      if (locPost != null) {
        removeLocationPost(locPost);
      }
    }
  }

  @override
  Future<DateTime?> getSimplePostDateTime(UuidValue id) async {
    final query = dbContext.selectOnly(dbContext.posts)
      ..addColumns([dbContext.posts.dataCreationTime])
      ..where(dbContext.posts.id.equals(id.uuid));

    final row = await query.getSingleOrNull();

    if (row == null) {
      return null;
    }
    return row.read(dbContext.posts.dataCreationTime);
  }
}
