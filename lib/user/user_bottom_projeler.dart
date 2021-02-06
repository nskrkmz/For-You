import 'package:flutter/material.dart';
import 'package:flutter_foru/user/user_drawer.dart';

class UserProjectPage extends StatefulWidget {
  @override
  _UserProjectPageState createState() => _UserProjectPageState();
}

class _UserProjectPageState extends State<UserProjectPage> {
  List<String> isimler = List();
  int voit = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: UserDrawerMenu(),
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: ButtonTheme(
                height: 35,
                minWidth: 375,

                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                  ),
                  color: Colors.blue,
                  onPressed: _projeEkle,
                  child: Text("Farklı Konu Seç"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                //width: 385,
                height: 550,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                child: ListView.builder(
                  itemBuilder: _urunler,
                  itemCount: isimler.length,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[


              ],
            ),
          ],
        )
    );
  }
  Widget _urunler(BuildContext context, int index) {
    return Card(
      color: Colors.white70,
      child: ListTile(
        leading: Icon(Icons.article_rounded),
        title: Text("Proje Başlığı"), //Firebase den alınacak
        subtitle: Text("Proje Açıklaması"), //Firebase den alınacak
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
  void _projeEkle (){
    setState(() {

      isimler.add("Card ${voit}");

    });
  }

}