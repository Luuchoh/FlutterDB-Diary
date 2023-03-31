
import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Modelo/Diary.dart';
import 'package:sqlite_flutter/Page/FormPage.dart';
import 'package:sqlite_flutter/Widget/Card/PageCard.dart';
import 'package:sqlite_flutter/Modelo/PageDiary.dart';

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
        builder: (BuildContext context) => FormPage(addPage, diary: widget.diary,)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenid@ a tu diario ${widget.diary.type}"),
        actions: <Widget>[
          IconButton(
            onPressed: addPages,
            icon: Icon(
              Icons.playlist_add,
            )
          ),
        ],
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
        PageDiary pageDiary = pages![index];
        return Dismissible(
          key: ObjectKey(pageDiary),
          onDismissed: (direction) {
            pageDiary.delete(pageDiary.id!);
            setState(() {
              pages?.removeAt(index);
            });
          },
          child: PageCard(addPage, pages![index])
        );
      });
  }

  addPage(PageDiary pageDiary) {
    pages?.add(pageDiary);
  }

  addPages() {
    List<PageDiary> pages = [
      PageDiary(
        id: 10,
        date: "15-04-2023",
        title: "Pagina 10",
        content: "Pagina 10",
        diaryId: 0
      ),
      PageDiary(
          id: 11,
          date: "15-04-2023",
          title: "Pagina 11",
          content: "Pagina 11",
          diaryId: 0
      ),
      PageDiary(
          id: 12,
          date: "15-04-2023",
          title: "Pagina 12",
          content: "Pagina 12",
          diaryId: 0
      ),
      PageDiary(
          id: 12,
          date: "15-04-2023",
          title: "Pagina 12",
          content: "Pagina 12",
          diaryId: 0
      ),
      PageDiary(
          id: 13,
          date: "15-04-2023",
          title: "Pagina 13",
          content: "Pagina 13",
          diaryId: 0
      ),
    ];
    PageDiary().insertPages(pages);
  }

}