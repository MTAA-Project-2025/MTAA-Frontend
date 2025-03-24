import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/posts/posts_table.dart';
import 'package:mtaa_frontend/domain/entities/users/user_table.dart';

class MyImageGroups extends Table{
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get position => integer()();
  TextColumn? get postId => text().nullable().references(Posts, #id)();
  TextColumn? get userId => text().nullable().references(Users, #id)();
}