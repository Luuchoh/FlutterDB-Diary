import 'package:sqlite_flutter/DataBase/CRUD.dart';
import 'package:sqlite_flutter/DataBase/DBTable.dart';

class Diary extends CRUD {

  int? id;
  String type;
  String enterCode;

  Diary ({this.id, this.type = "", this.enterCode = ""}): super(DBTable.DIARY);

  factory Diary.toObject(Map<dynamic, dynamic> data) {
    return (data != null)
              ? Diary(
                  id: data['id'],
                  type: data['type'],
                  enterCode: data['enterCode'],
                )
              : Diary();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'enterCode': enterCode,
    };
  }

  getList(parsed) {
    return (parsed as List).map((map) => Diary.toObject(map)).toList();
  }

  save() async{
    id = await insert(this.toMap());
    return (id !> 0) ? this : null;
  }

}