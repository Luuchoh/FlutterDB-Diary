import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Modelo/Diary.dart';
import 'package:sqlite_flutter/Page/HomePage.dart';

class LockScreen extends StatefulWidget {

  List<Diary>? diaries;
  LockScreen(this.diaries);

  @override
  State<StatefulWidget> createState() => LockScreenState(this.diaries);

}

class LockScreenState extends State<LockScreen> {

  List<Diary>? diaries;
  LockScreenState(this.diaries);
  bool isNewDiary = false;
  TextEditingController ctrlType = TextEditingController();
  TextEditingController ctrlCode = TextEditingController();
  Diary dropDownValue = Diary();

  @override
  void initState() {
    isNewDiary = diaries == null;
    dropDownValue = diaries != null ? diaries![0]: Diary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
          visible: !isNewDiary,
          child: dropDownButton(),
        ),
        Visibility(
          visible: isNewDiary,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Tipo de diario"
            ),
            keyboardType: TextInputType.text,
            controller: ctrlType,
          ),
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Código"
          ),
          keyboardType: TextInputType.text,
          controller: ctrlCode,
        ),
        ElevatedButton(
          onPressed: isNewDiary ? save : unlock ,
          child: Text(
            isNewDiary ? 'Guardar' : 'Desbloquear',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13
            ),
          ),
        )
      ],
    );
  }
  
  dropDownButton () {
    return (diaries != null)
    ? DropdownButton<Diary>(
        value: dropDownValue,
        icon: Icon(Icons.arrow_drop_down_rounded),
        items: diaries?.map<DropdownMenuItem<Diary>>((Diary value) {
          return DropdownMenuItem<Diary>(
            value: value,
            child: Text(value.type),
          );
        }).toList(),
        onChanged: (value) => onChangedDiary(value),
      )
    : SizedBox.shrink();
  }

  onChangedDiary (Diary? diary) {
    setState(() {
      this.dropDownValue = diary!;
    });
  }

  save () async {
    Diary diary = await Diary(type: ctrlType.text, enterCode: ctrlCode.text).save();
    if(diary != null) {
      goHome(diary);
    }
  }

  unlock() async {
    Diary diary = await dropDownValue.checkEnterCode(ctrlCode.text);
    if (diary != null) goHome(diary);
  }
  
  goHome(Diary diary) {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => MyHomePage(diary)
      )
    );
  }
}
