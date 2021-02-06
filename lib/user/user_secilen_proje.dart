import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/Proje.dart';



class UserSecilenProje extends StatefulWidget {
  Proje secilenProjeler;
  UserSecilenProje({this.secilenProjeler});

  @override
  _UserSecilenProjeState createState() => _UserSecilenProjeState();
}

class _UserSecilenProjeState extends State<UserSecilenProje> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.secilenProjeler.projeBaslik),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                border: Border.all(color: Colors.purple,width: 3),
              ),
              child: Text(widget.secilenProjeler.projeAyrtintilari),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue,width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Text(widget.secilenProjeler.projeSuresi),

            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text("Eklenecek Resim"),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              onPressed: (){},
              child: Text("Resim Seç"),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              onPressed: (){},
              child: Text("Yükle"),
            ),
          ],
        ),
      ),
    );
  }
}
