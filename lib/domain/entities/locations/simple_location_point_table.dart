import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/images/my_image_table.dart';

class SimpleLocationPoints extends Table{
  TextColumn get id => text()();
  TextColumn get postId => text().nullable()();
  RealColumn get longitude => real()();
  RealColumn get latitude => real()();
  IntColumn get type => integer()();
  IntColumn get zoomLevel => integer()();
  IntColumn get childCount => integer()();
  TextColumn get imageId => text().nullable().references(MyImages, #id)();

  TextColumn get currentUser => text()();

  @override
  Set<Column> get primaryKey => {id};
}