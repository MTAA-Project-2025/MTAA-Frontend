import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/users/user_table.dart';

class Posts extends Table{
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(Users, #id)();
  DateTimeColumn get dataCreationTime => dateTime()();

  IntColumn get version => integer()();

  @override
  Set<Column> get primaryKey => {id};
}