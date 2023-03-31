import 'package:sqlite_flutter/DataBase/CRUD.dart';
import 'package:sqlite_flutter/DataBase/DBTable.dart';
import 'package:sqflite/sqflite.dart';

class PageDiary extends CRUD {

  int? id;
  String date;
  String title;
  String content;
  int diaryId;

  PageDiary ({this.id, this.date = "", this.title = "", this.content = "", this.diaryId = 0}): super(DBTable.PAGE);

  factory PageDiary.toObject(Map<dynamic, dynamic> data) {
    return (data != null)
        ? PageDiary(
            id: data['id'],
            date: data['date'],
            title: data['title'],
            content: data['content'],
            diaryId: data['diaryId'],
          )
        : PageDiary();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
      'diaryId': diaryId,
    };
  }

  getList (parsed) {
    return (parsed as List).map((map) => PageDiary.toObject(map)).toList();
  }

  Future<List<PageDiary>> getPages(idDiary) async{
    var result = await query("SELECT * FROM ${DBTable.PAGE} WHERE diaryId = ?",
                            arguments: [idDiary]);
    return getList(result);
  }

  saveOrUpdate() async{
    id = (id != null) ? await update(this.toMap()): await insert(this.toMap());
    return (id !> 0) ? this : null;
  }

  insertPages(List<PageDiary> pages) async {
    final db = await database;
    db.transaction((database) async {
      Batch batch = database.batch();
      for(PageDiary pageDiary in pages) {
        batch.insert(table, pageDiary.toMap());
      }

      var result = await batch.commit(continueOnError: true, noResult: false);

      print("resultado $result");

    });
  }

}