import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Modelo/Diary.dart';
import 'package:sqlite_flutter/Modelo/PageDiary.dart';

class FormPage extends StatefulWidget {

  Diary? diary;
  Page? page;
  FormPage({this.diary, this.page});

  @override
  State<StatefulWidget> createState() => FormPageState();

}

class FormPageState extends State<FormPage> {

  PageDiary? page;
  TextEditingController ctrlDate = TextEditingController();
  TextEditingController ctrlTitle = TextEditingController();
  TextEditingController ctrlContent = TextEditingController();

  FormPageState({this.page});


  @override
  void initState() {
    if (page != null) {
      ctrlDate.text = page!.date;
      ctrlTitle.text = page!.title;
      ctrlContent.text = page!.content;
    } else {
      ctrlDate.text = DateTime.now().toString().substring(0, 11);
      ctrlTitle.text = "";
      ctrlContent.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: ctrlDate,
                enabled: false,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Titulo"
                ),
                keyboardType: TextInputType.text,
                controller: ctrlTitle,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Contenido"
                ),
                keyboardType: TextInputType.text,
                controller: ctrlContent,
              ),
              ElevatedButton(
                onPressed: save,
                child: Text(
                  'Guardar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  save () {

  }

}
