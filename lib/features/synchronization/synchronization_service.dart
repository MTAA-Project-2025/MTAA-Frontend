import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/data/network/locations_api.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/network/posts_api.dart';
import 'package:mtaa_frontend/features/posts/data/storages/posts_storage.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/synchronization/data/version_post_item_response.dart';
import 'package:mtaa_frontend/features/users/versioning/api/VersionItemsApi.dart';
import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';
import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';
import 'package:mtaa_frontend/features/users/versioning/storage/VersionItemsStorage.dart';

abstract class  SynchronizationService {
  Future synchronizePosts();
}

class SynchronizationServiceImpl extends  SynchronizationService {
  final PostsApi postsApi;
  final LocationsApi locationsApi;
  final PostsStorage postsStorage;
  final VersionItemsApi versionItemsApi;
  final VersionItemsStorage versionItemsStorage;

  bool isPostsSynchronizing = false;

  SynchronizationServiceImpl(this.postsApi,
  this.locationsApi,
  this.postsStorage,
  this.versionItemsApi,
  this.versionItemsStorage);

  @override
  Future synchronizePosts() async {
    if(isPostsSynchronizing)return;
    isPostsSynchronizing=true;

    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        return;
      }
    }
    var newVersions = await versionItemsApi.getVersionItems();
    var oldVersion = await versionItemsStorage.getVersionItem(VersionItemTypes.AccountPosts);

    VersionItem newVersionItem = newVersions.firstWhere((element) => element.type == VersionItemTypes.AccountPosts);

    int versionDifferency = newVersionItem.version - oldVersion;
    if(versionDifferency<=0){
      isPostsSynchronizing=false;
      return;
    }

    var pageParameters = PageParameters(pageNumber: 0, pageSize: 100);
    var oldPosts = await postsStorage.getVersionPostItems(pageParameters);
    
    while(versionDifferency>0){
      var newPosts = await postsApi.getVersionPostItems(pageParameters);
      if(newPosts.isEmpty)break;
      FullPostResponse? lastPost = await postsApi.getFullPostById(newPosts.last.id);
      if(newPosts.isEmpty)break;
      for (var post in newPosts) {
        VersionPostItemResponse? resp = oldPosts.where((e)=>e.id==post.id).firstOrNull;
        if(resp==null || resp.version<post.version){
          FullPostResponse? fullPost = await postsApi.getFullPostById(post.id);
          
          if(fullPost!=null){
            LocationPostResponse? locationPost;
            if(fullPost.locationId!=null){
              locationPost = await locationsApi.getLocationPostById(fullPost.locationId!);
            }
            versionDifferency-=(await postsStorage.updatePost(fullPost, locationPost, post.version)+1);
          }
        }
      }
      for(var oldPost in oldPosts){
        VersionPostItemResponse? resp = newPosts.where((e)=>e.id==oldPost.id).firstOrNull;
        if(resp==null){
          DateTime? dateTime = await postsStorage.getSimplePostDateTime(oldPost.id);
          if(dateTime!=null && lastPost!=null){
            await postsStorage.deletePost(oldPost.id);
            versionDifferency--;
          }
        }
      }
      pageParameters.pageNumber++;
    }
    await versionItemsStorage.saveVersionItem(VersionItem(
      type: VersionItemTypes.AccountPosts,
      version: newVersionItem.version,
    ));
    isPostsSynchronizing=false;
  }
}
