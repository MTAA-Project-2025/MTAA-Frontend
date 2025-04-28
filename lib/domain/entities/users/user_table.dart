import 'package:drift/drift.dart';

class Users extends Table{
  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get displayName => text()();
  DateTimeColumn get birthDate => dateTime()();
  TextColumn get status => text()();
  DateTimeColumn get lastSeen => dateTime()();
  DateTimeColumn get dataCreationTime => dateTime()();

  TextColumn get currentUser => text()();

  BoolColumn get isSimple => boolean()();

  BoolColumn get isTempRecommendation => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}