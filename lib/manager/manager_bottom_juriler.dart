import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/Juri.dart';


class ManagerJuriEkran extends StatefulWidget {
  @override
  _ManagerJuriEkranState createState() => _ManagerJuriEkranState();
}

class _ManagerJuriEkranState extends State<ManagerJuriEkran> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List <Juri> tumJuriler = List();

  String _okunanjuriAd = "default";
  String _okunanjuriSoyad = "default";
  String _okunanjuriEmail = "default";
  String _okunanjuriPassword = "default";
  String _okunanjurimeslek = "default";
  @override
  void initState() {
    super.initState();
    tumJuriler = [];
    _firebaseFirestore.collection('jüriler').get().then((gelenVeri) {
      for(int i = 0; i< gelenVeri.docs.length; i++){
        setState(() {
          _okunanjuriAd = gelenVeri.docs[i].data()['Juri Ad'];
          _okunanjuriSoyad = gelenVeri.docs[i].data()['Juri Soyad'];
          _okunanjuriEmail = gelenVeri.docs[i].data()['Juri Email'];
          _okunanjuriPassword = gelenVeri.docs[i].data()['Juri Sifre'];
          _okunanjurimeslek = gelenVeri.docs[i].data()['Juri Meslek'];
        });
        tumJuriler.add(Juri(juriAd: _okunanjuriAd, juriSoyad: _okunanjuriSoyad, juriEmail: _okunanjuriEmail, juriPassword: _okunanjuriPassword, juriMeslek: _okunanjurimeslek));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: _listeElemanlariniGetir,
        itemCount: tumJuriler.length,
      ),
    );
  }

  Widget _listeElemanlariniGetir(BuildContext context, int index) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.people,color: Colors.purple,),
        title: Text("Juri Adı Soyadı: ${tumJuriler[index].juriAd}${tumJuriler[index].juriSoyad}"),
        subtitle: Text("${tumJuriler[index].juriMeslek}",),
      ),
    );

  }
}