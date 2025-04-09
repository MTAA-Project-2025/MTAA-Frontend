import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/images/my_image_group_table.dart';

class Users extends Table{
  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get displayName => text()();
  DateTimeColumn get birthDate => dateTime()();
  TextColumn get status => text()();
  DateTimeColumn get lastSeen => dateTime()();
  DateTimeColumn get dataCreationTime => dateTime()();
  TextColumn? get avatarId => text().nullable().references(MyImageGroups, #id)();

  TextColumn get currentUser => text()();

  BoolColumn get isSimple => boolean()();

  BoolColumn get isTempRecommendation => boolean()();
}