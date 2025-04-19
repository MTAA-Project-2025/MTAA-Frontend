import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/images/my_image_group_table.dart';
import 'package:mtaa_frontend/domain/entities/locations/simple_location_point_table.dart';
import 'package:mtaa_frontend/domain/entities/posts/location_posts_table.dart';
import 'package:mtaa_frontend/domain/entities/posts/posts_table.dart';

class MyImages extends Table{
  TextColumn get id => text()();
  TextColumn get shortPath => text()();
  TextColumn get fullPath => text()();
  TextColumn get localFullPath => text()();
  TextColumn get fileType => text()();
  IntColumn get height => integer()();
  IntColumn get width => integer()();
  RealColumn get aspectRatio => real()();
  IntColumn get type => integer()();
  TextColumn get myImageGroupId => text().references(MyImageGroups, #id)();

  TextColumn? get postId => text().nullable().references(Posts, #id)();
  TextColumn? get locationPostId => text().nullable().references(LocationPosts, #id)();
  TextColumn? get simpleLocationPointId => text().nullable().references(SimpleLocationPoints, #id)();
}