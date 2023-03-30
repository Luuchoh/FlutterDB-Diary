import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_flutter/DataBase/DBTable.dart';

class DB {

  String name = 'DiaryApp';
  int version = 1;

  Future<Database> open () async {
    String path = join(await getDatabasesPath(), name);
    return await openDatabase(
      path,
      version: version,
      // readOnly: true
      onConfigure: onConfigure,
      onCreate: onCreate
    );
  }

  onConfigure (Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  onCreate (Database db, int version) async{
    DBTable.TABLES.forEach((script) async => await db.execute(script));
  }
}