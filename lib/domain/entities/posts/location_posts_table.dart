import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/images/my_image_table.dart';
import 'package:mtaa_frontend/domain/entities/locations/simple_location_point_table.dart';

class LocationPosts extends Table{
  TextColumn get id => text()();
  TextColumn get locationId => text().nullable()();
  DateTimeColumn get eventTime => dateTime()();
  TextColumn get description => text()();
  TextColumn get ownerDisplayName => text()();
  TextColumn get pointId => text().references(SimpleLocationPoints, #id)();
  TextColumn get smallFirstImageId => text().references(MyImages, #id)();
  DateTimeColumn get dataCreationTime => dateTime()();

  TextColumn get currentUser => text()();

  @override
  Set<Column> get primaryKey => {id};
}