import 'package:drift/drift.dart';

class Locations extends Table{
  TextColumn get id => text()();

  @override
  Set<Column> get primaryKey => {id};
}