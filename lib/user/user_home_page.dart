import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/Proje.dart';
import 'package:flutter_foru/user/user_drawer.dart';
import 'package:flutter_foru/user/user_secilen_proje.dart';

class UserProjectPage extends StatefulWidget {
  FirebaseAuth firebaseAuthUser;
  UserProjectPage({this.firebaseAuthUser});
  @override
  _UserProjectPageState createState() => _UserProjectPageState();
}

class _UserProjectPageState extends State<UserProjectPage> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List <Proje> tumProjeler = List();

  // Firebase den çekilen verilerin tutulduğu değişkenler
  String okunanProjeID;
  String okunanProjeBaslik;
  String okunanProjeKategori;
  String okunanProjeJuri;
  String okunanProjeOdul;
  String okunanProjeSuresi;
  String okunanProjeAyrintilar;

  // Firebase den çekilen verilerin tutulduğu değişkenler

  @override
  void initState() {
    super.initState();
    tumProjeler = [];
    // Firebase den verilerin çekilmesi
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
      appBar: AppBar(
        title: Text("Projeler"),
        centerTitle: true,
      ),
      drawer: UserDrawerMenu(firebaseAuthUser: widget.firebaseAuthUser),
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
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserSecilenProje(secilenProjeler: tumProjeler[index],firebaseAuthUser: widget.firebaseAuthUser,)));
                                  }
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


