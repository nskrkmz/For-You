import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/Proje.dart';


class ManagerProjeIslemleri extends StatefulWidget {
  @override
  _ManagerProjeIslemleriState createState() => _ManagerProjeIslemleriState();
}

class _ManagerProjeIslemleriState extends State<ManagerProjeIslemleri> {

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // Firebase e eklenen projeler aynı zamanda localde bir listede tutuluyor. 
  List<Proje> tumProjeler = List();
  
  var projeKey = GlobalKey<FormState>();
  String _projeID = "default";
  String _projeBaslik = "default";
  String _projeKatogori = "default";
  String _projejuri = "default";
  String _projeOdul = "default";
  String _projeSure = "default";
  String _projeAyrinti = "default";
  Map<String, dynamic> projeAyrtintilari = Map();
  @override
  void initState() {
    super.initState();
    tumProjeler.add(Proje(projeID: "Default", projeBaslik: "Default", projeJuri: "Default", projeOdul: "Default",projeAyrtintilari: "Default"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proje islemleri"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Form(
          key: projeKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10,),
              // Proje Başlığı
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Proje Başlığı",
                  labelText: "Proje Başlığı",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (baslik){
                  _projeBaslik = baslik;
                },
              ),
              SizedBox(height: 10),
              // Proje Katogorisi
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Proje Katogorisi",
                  labelText: "Proje Katogorisi",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (katagori){
                  _projeKatogori = katagori;
                },
              ),
              SizedBox(height: 10),
              // Proje Juri
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.people),
                  hintText: "Proje Jürisi",
                  labelText: "Proje Jürisi",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (girilenjuri){
                  _projejuri = girilenjuri;
                },
              ),
              SizedBox(height: 10),
              // Proje Odul
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Proje Odul",
                  labelText: "Proje Odul",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (odul){
                  _projeOdul = odul;
                },
              ),
              SizedBox(height: 10),
              //Proje Süresi
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.timer),
                  hintText: "Proje süresi",
                  labelText: "Proje süresi",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (sure){
                  _projeSure = sure;
                },
              ),
              SizedBox(height: 10),
              //Proje Ayrıntıları
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pages_rounded),
                  hintText: "Proje Ayrıntıları",
                  labelText: "Proje Ayrıntıları",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (String girilenVeri){
                  if(girilenVeri.length <= 6 ){
                    return "Şifre 6 karakterden az olamaz";
                  }else{
                    return null;
                  }
                },
                onSaved: (ayrinti){
                  _projeAyrinti = ayrinti;
                },
              ),
              SizedBox(height: 10),
              // GirişButonu
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                icon: Icon(Icons.arrow_forward,color: Colors.white,),
                label: Text("Projeyi Yayınla",style: TextStyle(color: Colors.white),),
                onPressed: (){
                  projeKey.currentState.save();
                  projeKey.currentState.reset();
                  // Hem firebase e hemde local listeye ekleme yapıyor. Liste uzunluğunu belirliyor.
                  setState(() {
                    tumProjeler.add(Proje(projeID: _projeID, projeBaslik: _projeBaslik, projeJuri: _projejuri, projeOdul: _projeOdul,projeAyrtintilari: _projeAyrinti));
                  });
                  _firebaseFirestore.collection('Projeler').doc('Pr${tumProjeler.length}').set(projeAyrintiGetir());
                },
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> projeAyrintiGetir(){

    projeAyrtintilari['Proje ID'] = tumProjeler.length;
    projeAyrtintilari['Proje Başlığı'] = _projeBaslik;
    projeAyrtintilari['Proje Katogorisi'] = _projeKatogori;
    projeAyrtintilari['Proje Jürisi'] = _projejuri;
    projeAyrtintilari['Proje Odul'] = _projeOdul;
    projeAyrtintilari['Proje Süre'] = _projeSure;
    projeAyrtintilari['Proje Ayrıntıları'] = _projeAyrinti;
    return projeAyrtintilari;
  }
}

/*
Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(child: Text("Proje ID: PR${tumProjeler.length + 1}", style: TextStyle(fontSize: 20))),
              ),
*/