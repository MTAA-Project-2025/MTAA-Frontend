import 'package:drift/drift.dart';
import 'package:mtaa_frontend/domain/entities/users/user_table.dart';

class Posts extends Table{
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(Users, #id)();
  DateTimeColumn get dataCreationTime => dateTime()();

  TextColumn get currentUser => text()();
}