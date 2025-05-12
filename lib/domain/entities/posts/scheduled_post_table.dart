import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/images/my_image_table.dart';

class SchedulePosts extends Table{
  TextColumn get id => text()();
  TextColumn get description => text()();
  TextColumn get smallFirstImageId => text().references(MyImages, #id)();
  BoolColumn get isHidden => boolean()();
  DateTimeColumn get schedulePublishDate => dateTime().nullable()();
  TextColumn get hiddenReason => text().nullable()();
  
  DateTimeColumn get dataCreationTime => dateTime()();

  IntColumn get version => integer()();

  @override
  Set<Column> get primaryKey => {id};
}