import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Modelo/Diary.dart';
import 'package:sqlite_flutter/Widget/LockScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Diary>>(
            future: Diary().getDiaries(),
            initialData: List.empty(),
            builder: (BuildContext context, AsyncSnapshot<List<Diary>> snapshot) {
              return (snapshot.connectionState == ConnectionState.done)
                  ? LockScreen(snapshot.data)
                  : CircularProgressIndicator();
            },
          ),
        ),
      )


    );
  }
}


