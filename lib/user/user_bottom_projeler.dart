import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/Proje.dart';
import 'package:flutter_foru/user/user_drawer.dart';
import 'package:flutter_foru/user/user_secilen_proje.dart';

class UserProjectPage extends StatefulWidget {
  @override
  _UserProjectPageState createState() => _UserProjectPageState();
}

class _UserProjectPageState extends State<UserProjectPage> {
  //List<String> isimler = List();
  //int voit = 0;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List <Proje> tumProjeler = List();
  String okunanProjeID;
  String okunanProjeBaslik;
  String okunanProjeKategori;
  String okunanProjeJuri;
  String okunanProjeOdul;
  String okunanProjeSuresi;
  String okunanProjeAyrintilar;

  Color color1 = const Color(0xFFEA4C4D);
  Color color2 = const Color(0xFFEDB758);
  @override
  void initState() {
    super.initState();
    tumProjeler = [];
    _firebaseFirestore.collection('Projeler').get().then((gelenVeri) {
      for(int i = 0; i< gelenVeri.docs.length; i++){
        setState(() {
          okunanProjeID = gelenVeri.docs[i].data()['Proje ID'];
          okunanProjeBaslik = gelenVeri.docs[i].data()['Proje Başlığı'];
          okunanProjeKategori = gelenVeri.docs[i].data()['Proje Katogorisi'];
          okunanProjeJuri = gelenVeri.docs[i].data()['Proje Jürüsi'];
          okunanProjeOdul = gelenVeri.docs[i].data()['Proje Odul'];
          okunanProjeSuresi = gelenVeri.docs[i].data()['Proje Süre'];
          okunanProjeAyrintilar = gelenVeri.docs[i].data()['Proje Ayrıntıları'];
        });
        tumProjeler.add(Proje(projeID: okunanProjeID, projeBaslik: okunanProjeBaslik, projeKategori: okunanProjeKategori, projeJuri: okunanProjeJuri, projeOdul: okunanProjeOdul, projeSuresi: okunanProjeSuresi, projeAyrtintilari: okunanProjeAyrintilar));
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView.builder(
            itemBuilder: _listeElemanOlustur,
            itemCount: tumProjeler.length,
          ),
        ),
    );
  }

  Widget _listeElemanOlustur(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [color1,color2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40.0),bottomLeft: Radius.circular(40.0)),
                ),
                height: 220,
                width: 100,
                child: Column(
                  children: <Widget>[
                    // Proje baslıgı
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(tumProjeler[index].projeBaslik)
                    ),
                    // Proje acıklaması
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(tumProjeler[index].projeAyrtintilari),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("Proje Süresi: " + tumProjeler[index].projeSuresi),
                            SizedBox(height: 3,),
                            Text("Proje Ödülü: " + tumProjeler[index].projeOdul),
                          ],
                        ),
                        IconButton(
                          color: Colors.blue,
                          icon: Icon(Icons.arrow_forward,size:30),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserSecilenProje(secilenProjeler: tumProjeler[index],)));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}



/*
Column(
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
*/