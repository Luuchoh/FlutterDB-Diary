import 'package:sqlite_flutter/DataBase/CRUD.dart';
import 'package:sqlite_flutter/DataBase/DBTable.dart';

class PageDiary extends CRUD {

  int? id;
  String date;
  String title;
  String content;
  int idDiary;

  PageDiary ({this.id, this.date = "", this.title = "", this.content = "", this.idDiary = 0}): super(DBTable.PAGE);

  factory PageDiary.toObject(Map<dynamic, dynamic> data) {
    return (data != null)
        ? PageDiary(
      id: data['id'],
      date: data['date'],
      title: data['title'],
      content: data['content'],
      idDiary: data['idDiary'],
    )
        : PageDiary();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
      'idDiary': idDiary,
    };
  }

  getList (parsed) {
    return (parsed as List).map((map) => PageDiary.toObject(map)).toList();
  }

}