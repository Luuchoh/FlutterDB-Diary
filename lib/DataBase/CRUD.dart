import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutter/DataBase/DB.dart';

abstract class CRUD {

  final String table;
  const CRUD (this.table);

  Future<Database> get database async {
    return DB().open();
  }

  query (String sql, {List<dynamic>? arguments}) async {
    final db = await database;

    // 'OR 1=1 --' --SQLInjection
    // db.execute(sql)
    // db.query(table)

    var response = await db.rawQuery(sql, arguments);
    return response;
  }

  update (Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(table, data, where: "id =?", whereArgs: [data['id']]);
  }

  insert (Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  delete (int id) async {
    final db = await database;
    return await db.delete(table, where: "id =?", whereArgs: [id]);
  }
}