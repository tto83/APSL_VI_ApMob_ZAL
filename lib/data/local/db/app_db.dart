import 'dart:io';

import 'package:baza_praconikow/data/local/entity/employee_entity.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'employee.sqlite'));

    return NativeDatabase(file);
  });
}


@DriftDatabase(tables: [Employee])

class AppDb extends _$AppDb {

    AppDb(): super(_openConnection());

    @override
    int get schemaVersion => 1;

}