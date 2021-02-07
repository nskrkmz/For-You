import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'Proje.dart';

class ManagerIlkEkran extends StatefulWidget {
  @override
  _ManagerIlkEkranState createState() => _ManagerIlkEkranState();
}

class _ManagerIlkEkranState extends State<ManagerIlkEkran> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List <Proje> tumProjeler = List();
  String okunanProjeID;
  String okunanProjeBaslik;
  String okunanProjeKategori;
  String okunanProjeJuri;
  String okunanProjeOdul;
  String okunanProjeSuresi;
  String okunanProjeAyrintilar;
  Color color1 = const Color(0xFFFFE1B5);
  Color color2 = const Color(0xFFFF7F50);
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
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepOrange,Colors.pink.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40.0),bottomLeft: Radius.circular(40.0)),
                ),
                height: 220,
                width: 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // Proje baslıgı
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                          child: Text(tumProjeler[index].projeBaslik,style: TextStyle(fontFamily: 'GovdeFont',color: Colors.white,fontWeight: FontWeight.bold),)
                      ),
                      // Proje acıklaması
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        padding: EdgeInsets.all(20.0),
                        child: Text(tumProjeler[index].projeAyrtintilari,style: TextStyle(fontFamily: 'GovdeFont',color: Colors.white,fontWeight: FontWeight.bold)),
                      ),
                      // Proje süresi ve Ödülü
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.shade400,
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("Proje Süresi: " + tumProjeler[index].projeSuresi,style: TextStyle(fontFamily: 'GovdeFont',color: Colors.white,fontWeight: FontWeight.bold)),
                                SizedBox(height: 3,),
                                Text("Proje Ödülü: " + tumProjeler[index].projeOdul,style: TextStyle(fontFamily: 'GovdeFont',color: Colors.white,fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text("Ayrıntılar...",style: TextStyle(fontFamily: 'GovdeFont',color: Colors.white,fontWeight: FontWeight.bold)),
                              IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: (){}
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
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
