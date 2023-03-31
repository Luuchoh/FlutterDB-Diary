import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_flutter/DataBase/DBMigration.dart';
import 'package:sqlite_flutter/DataBase/DBTable.dart';

class DB {

  String name = 'DiaryApp';
  int version = 2;

  Future<Database> open () async {
    String path = join(await getDatabasesPath(), name);
    return await openDatabase(
      path,
      version: version,
      // readOnly: true
      onConfigure: onConfigure,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  onCreate(Database db, int version) async{
    DBTable.TABLES.forEach((script) async => await db.execute(script));
  }

  onUpgrade(Database db, int oldVersion, int newVersion) {
    if(oldVersion < newVersion) {
      print("Actualizar Antigua: $oldVersion Nueva: $newVersion");
      DBMigration.MIGRATION_SCRIPTS.forEach((scripts) async => await db.execute(scripts));
    }
  }
}