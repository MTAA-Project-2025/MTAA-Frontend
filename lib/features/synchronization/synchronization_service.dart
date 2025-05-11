import 'dart:async';

import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/services/internet_checker.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/data/network/locations_api.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_bloc.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_event.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_state.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/network/posts_api.dart';
import 'package:mtaa_frontend/features/posts/data/storages/posts_storage.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/synchronization/data/version_post_item_response.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_bloc.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_events.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/versioning/api/VersionItemsApi.dart';
import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';
import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';
import 'package:mtaa_frontend/features/users/versioning/storage/VersionItemsStorage.dart';
import 'package:uuid/uuid.dart';

abstract class SynchronizationService {
  Future synchronizePosts(int versionDifferency, int newVersion);
  Future synchronizeAccount(int newFollowersVersion, int newFriendsVersion, int newAccountVersion, int newLikedPostsVersion);
  Future synchronize();
  Future initializeSyncLoad();
}

class SynchronizationServiceImpl extends SynchronizationService {
  final PostsApi postsApi;
  final AccountApi accountApi;
  final LocationsApi locationsApi;
  final PostsStorage postsStorage;
  final VersionItemsApi versionItemsApi;
  final VersionItemsStorage versionItemsStorage;

  bool isPostsSynchronizing = false;
  bool isSynchronizeLoading = false;

  Timer? syncTimer;

  SynchronizationServiceImpl(this.postsApi,
  this.locationsApi,
  this.postsStorage,
  this.versionItemsApi,
  this.versionItemsStorage, 
  this.accountApi);

  @override
  Future initializeSyncLoad() async{
    InternetChecker.connectionStream.listen((hasConnection) async {
      if (hasConnection) {
        await synchronize();
      }
    });

    syncTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (await InternetChecker.isInternetEnabled()) {
        await synchronizeLoad();
      }
    });
  }

  
  Future synchronizeLoad() async {
    if (!getIt.isRegistered<BuildContext>()) return;
    var context = getIt.get<BuildContext>();
    if (!context.mounted) return;
    ScheduledPostsBloc bloc = context.read<ScheduledPostsBloc>();
    ScheduledPostsState state = bloc.state;
    if (isSynchronizeLoading || state.notSyncedPosts.isEmpty) return;

    isSynchronizeLoading = true;

    try {
      await Future.delayed(Duration(seconds: 1));


      for (final post in state.notSyncedPostsHive) {
        UuidValue? id = await postsApi.addPost(post);
        if (id != null) {
          bloc.add(RemoveScheduledPostHiveEvent(post: post));
        }
      }
    } finally {
      isSynchronizeLoading = false;
    }
  }

  @override
  Future synchronize() async {
    try {
      var newVersions = await versionItemsApi.getVersionItems();
      if (newVersions.isEmpty) return;
      var oldPostsVersion = await versionItemsStorage.getVersionItem(VersionItemTypes.AccountPosts);
      var oldAccountVersion = await versionItemsStorage.getVersionItem(VersionItemTypes.Account);
      var oldFriendsVersion = await versionItemsStorage.getVersionItem(VersionItemTypes.Friends);
      var oldFollowersVersion = await versionItemsStorage.getVersionItem(VersionItemTypes.Followers);
      var oldLikedPostsVersion = await versionItemsStorage.getVersionItem(VersionItemTypes.LikedPosts);

      VersionItem newPostsVersionItem = newVersions.firstWhere((element) => element.type == VersionItemTypes.AccountPosts);
      int postsVersionDifferency = newPostsVersionItem.version - oldPostsVersion;
      if (postsVersionDifferency > 0) {
        synchronizePosts(postsVersionDifferency, newPostsVersionItem.version);
      }

      VersionItem newFollowersVersionItem = newVersions.firstWhere((element) => element.type == VersionItemTypes.Followers);
      int followersVersionDifferency = newFollowersVersionItem.version - oldFollowersVersion;

      VersionItem newFriendsVersionItem = newVersions.firstWhere((element) => element.type == VersionItemTypes.Friends);
      int friendsVersionDifferency = newFriendsVersionItem.version - oldFriendsVersion;

      VersionItem newAccountVersionItem = newVersions.firstWhere((element) => element.type == VersionItemTypes.Account);
      int accountVersionDifferency = newAccountVersionItem.version - oldAccountVersion;

      VersionItem newLikedPostsVersionItem = newVersions.firstWhere((element) => element.type == VersionItemTypes.LikedPosts);
      int accountLikedPostsDifferency = newLikedPostsVersionItem.version - oldLikedPostsVersion;

      synchronizeAccount(followersVersionDifferency, friendsVersionDifferency, accountVersionDifferency, accountLikedPostsDifferency);
    } catch (e) {
      print('Error while synchronization: $e');
      return;
    }
  }

  @override
  Future synchronizeAccount(int newFollowersVersion, int newFriendsVersion, int newAccountVersion, int newLikedPostsVersion) async {
    try {
      if (!getIt.isRegistered<BuildContext>()) return;
      var context = getIt.get<BuildContext>();
      var account = await accountApi.getFullAccount();
      if (account == null) return;
      if (!context.mounted) return;
      context.read<AccountBloc>().add(LoadAccountEvent(account: account));

      await versionItemsStorage.saveVersionItem(VersionItem(
        type: VersionItemTypes.Account,
        version: newAccountVersion,
      ));
      await versionItemsStorage.saveVersionItem(VersionItem(
        type: VersionItemTypes.Followers,
        version: newFollowersVersion,
      ));
      await versionItemsStorage.saveVersionItem(VersionItem(
        type: VersionItemTypes.Friends,
        version: newFriendsVersion,
      ));
      await versionItemsStorage.saveVersionItem(VersionItem(
        type: VersionItemTypes.LikedPosts,
        version: newLikedPostsVersion,
      ));
    } catch (e) {
      print('Error while synchronization: ');
    }
  }

  @override
  Future synchronizePosts(int versionDifferency, int newVersion) async {
    try {
      if (isPostsSynchronizing) return;
      isPostsSynchronizing = true;

      final status = await AirplaneModeChecker.instance.checkAirplaneMode();
      if (status == AirplaneModeStatus.on) {
        if (getIt.isRegistered<BuildContext>()) {
          var context = getIt.get<BuildContext>();
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
          return;
        }
      }

      var pageParameters = PageParameters(pageNumber: 0, pageSize: 100);
      var oldPosts = await postsStorage.getVersionPostItems(pageParameters);
      var oldScheduledPosts = await postsStorage.getVersionScheduledPostItems(pageParameters);

      while (versionDifferency > 0) {
        var newPosts = await postsApi.getVersionPostItems(pageParameters);
        if (newPosts.isEmpty) break;
        FullPostResponse? lastPost = await postsApi.getFullPostById(newPosts.last.id);
        if (newPosts.isEmpty) break;
        for (var post in newPosts) {
          VersionPostItemResponse? resp = oldPosts.where((e) => e.id == post.id).firstOrNull;
          if (resp == null || resp.version < post.version) {
            FullPostResponse? fullPost = await postsApi.getFullPostById(post.id);

            if (fullPost != null) {
              LocationPostResponse? locationPost;
              if (fullPost.locationId != null) {
                locationPost = await locationsApi.getLocationPostById(fullPost.locationId!);
              }
              versionDifferency -= (await postsStorage.updatePost(fullPost, locationPost, post.version) + 1);
              if (fullPost.isHidden) {
                var schedulePost = await postsApi.getSchedulePostById(post.id);
                if (schedulePost != null) {
                  await postsStorage.updateSchedulePost(schedulePost, schedulePost.version);
                }
              }
            }
          }
        }
        if (versionDifferency > 0) {
          for (var oldPost in oldPosts) {
            VersionPostItemResponse? resp = newPosts.where((e) => e.id == oldPost.id).firstOrNull;
            if (resp == null) {
              DateTime? dateTime = await postsStorage.getSimplePostDateTime(oldPost.id);
              if (dateTime != null && lastPost != null) {
                await postsStorage.deletePost(oldPost.id);
                versionDifferency--;
              }
            }
          }
        }
        for (var oldPost in oldScheduledPosts) {
          VersionPostItemResponse? resp = newPosts.where((e) => e.id == oldPost.id).firstOrNull;
          if (resp == null) {
            DateTime? dateTime = await postsStorage.getSimplePostDateTime(oldPost.id);
            if (dateTime != null && lastPost != null) {
              var sPost = await postsApi.getSchedulePostById(oldPost.id);
              if (sPost != null) {
                await postsStorage.removeSchedulePost(sPost);
                versionDifferency--;
              }
            }
          }
        }

        pageParameters.pageNumber++;
      }
      await versionItemsStorage.saveVersionItem(VersionItem(
        type: VersionItemTypes.AccountPosts,
        version: newVersion,
      ));
      isPostsSynchronizing = false;
    } catch (e) {
      print('Error while synchronization: $e');
      return;
    }
  }
}
