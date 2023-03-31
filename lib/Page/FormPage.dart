import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Modelo/Diary.dart';
import 'package:sqlite_flutter/Modelo/PageDiary.dart';

typedef VoidCallbackParam(PageDiary pageDiary);

class FormPage extends StatefulWidget {

  VoidCallbackParam voidCallbackParam;
  Diary? diary;
  PageDiary? page;

  FormPage(this.voidCallbackParam, {this.diary, this.page});

  @override
  State<StatefulWidget> createState() => FormPageState(page: page);

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

  getTextBox() {
    page = (page != null) ? page : PageDiary(diaryId: widget.diary!.id!);

    page!.title = ctrlTitle.text;
    page!.content = ctrlContent.text;
    page!.date = ctrlDate.text;
  }

  save() async {
    getTextBox();
    PageDiary pageDiary = await this.page?.saveOrUpdate();
    
    if(pageDiary !=  null) {
      widget.voidCallbackParam(pageDiary);
      Navigator.pop(context);
    }
  }

}
