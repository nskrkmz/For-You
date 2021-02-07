import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/Proje.dart';


class UserTamamlananProjeler extends StatefulWidget {
  @override
  _UserTamamlananProjelerState createState() => _UserTamamlananProjelerState();
}

class _UserTamamlananProjelerState extends State<UserTamamlananProjeler> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Proje> tamamlananProjeler = List();

  String okunanProjeBaslik;
  String okunanProjeOdul;
  String okunanProjeSuresi;

  @override
  void initState() {
    super.initState();
    _firebaseFirestore.collection('Tamamlanmış Projeler').get().then((gelenVeri) {
      for(int i = 0; i< gelenVeri.docs.length; i++){
        setState(() {
          okunanProjeBaslik = gelenVeri.docs[i].data()['Proje Başlığı'];
          okunanProjeOdul = gelenVeri.docs[i].data()['Proje Odul'];
          okunanProjeSuresi = gelenVeri.docs[i].data()['Proje Süre'];
        });
        tamamlananProjeler.add(Proje( projeBaslik: okunanProjeBaslik, projeOdul: okunanProjeOdul, projeSuresi: okunanProjeSuresi));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tamamlanmış Projeler"),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: _listeElemanlariniGetir,
          itemCount: tamamlananProjeler.length,
        ),
      ),
    );
  }

  Widget _listeElemanlariniGetir(BuildContext context, int index) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.pages_rounded,color: Colors.green),
        title: Text("Proje Başlığı: " + tamamlananProjeler[index].projeBaslik),
        subtitle: Text("Proje süresi: " + tamamlananProjeler[index].projeSuresi),
        trailing: Icon(Icons.done,color: Colors.green,size: 30),
      ),
    );


  }
}
