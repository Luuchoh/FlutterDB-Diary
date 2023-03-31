
import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Modelo/Diary.dart';
import 'package:sqlite_flutter/Page/FormPage.dart';
import 'package:sqlite_flutter/Widget/Card/PageCard.dart';

import '../Modelo/PageDiary.dart';

class MyHomePage extends StatefulWidget {

  Diary diary;

  MyHomePage(this.diary);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  List<PageDiary>? pages;

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
      body: Center(
        child: FutureBuilder<List<PageDiary>>(
          future: PageDiary().getPages(widget.diary.id),
          initialData: List.empty(),
          builder: (BuildContext context, AsyncSnapshot<List<PageDiary>> snapshot) {
            this.pages = snapshot.data;
            return (snapshot.connectionState == ConnectionState.done)
                ? getListView()
                : CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goForm,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  getListView () {
    return ListView.builder(
      itemCount: pages?.length,
      itemBuilder: (BuildContext context, int index) {
        return PageCard(pages![index]);
      });
  }

}