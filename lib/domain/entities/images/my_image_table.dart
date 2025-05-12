import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/locations/simple_location_point_table.dart';
import 'package:mtaa_frontend/domain/entities/posts/location_posts_table.dart';
import 'package:mtaa_frontend/domain/entities/posts/posts_table.dart';
import 'package:mtaa_frontend/domain/entities/posts/scheduled_post_table.dart';

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

  TextColumn? get postId => text().nullable().references(Posts, #id)();
  TextColumn? get locationPostId => text().nullable().references(LocationPosts, #id)();
  TextColumn? get schedulePostId => text().nullable().references(SchedulePosts, #id)();
  TextColumn? get simpleLocationPointId => text().nullable().references(SimpleLocationPoints, #id)();

  @override
  Set<Column> get primaryKey => {id};
}