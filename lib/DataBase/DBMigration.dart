import 'package:sqlite_flutter/DataBase/DBTable.dart';

class DBMigration {

  static const MIGRATION_SCRIPTS = [
    "ALTER TABLE ${DBTable.DIARY} ADD COLUMN color TEXT;",
  ];

}