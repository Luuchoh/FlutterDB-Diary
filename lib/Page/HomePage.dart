
import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Modelo/Diary.dart';
import 'package:sqlite_flutter/Page/FormPage.dart';
import 'package:sqlite_flutter/Widget/Card/PageCard.dart';

import '../Modelo/PageDiary.dart';

class MyHomePage extends StatefulWidget {

  Diary diary;

  MyHomePage(this.diary);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<PageDiary>?  pages;

  void goForm() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => FormPage()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenid@ a tu diario ${widget.diary.type}"),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: goForm,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  getListView () {
    return ListView.builder(
      itemCount: pages!.length,
      itemBuilder: (BuildContext context, int index) {
        return PageCard(pages![index]);
      });
  }

}