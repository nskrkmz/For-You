import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ManagerJuriIslemleri extends StatefulWidget {
  @override
  _ManagerJuriIslemleriState createState() => _ManagerJuriIslemleriState();
}

class _ManagerJuriIslemleriState extends State<ManagerJuriIslemleri> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String _juriAd = "default";
  String _juriSoyad = "default";
  String _juriEmail = "default";
  String _juriPassword = "default";
  String _jurimeslek = "default";
  var juriKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jüri İşlemleri"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Form(
          key: juriKey,
          child: ListView(
            children: <Widget>[
              // Juri ad
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Juri Adı",
                  labelText: "Juri Adı",
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
                onSaved: (girilenAd){
                  _juriAd = girilenAd;
                },
              ),
              SizedBox(height: 10),
              // Juri Soyad
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Juri Soyad",
                  labelText: "Juri Soyad",
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
                onSaved: (girilenSoyad){
                  _juriSoyad = girilenSoyad;
                },
              ),
              SizedBox(height: 10),
              // Juri Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "E mail",
                  labelText: "E mail",
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
                validator: (String girilenVeri){
                  if (!(girilenVeri.contains("@gmail.com")|| girilenVeri.contains("@hotmail.com") || girilenVeri.contains("@outlook.com") || girilenVeri.contains("@bil.omu.edu.tr"))){
                    return "Lütfen geçerli bir e mail giriniz";
                  }else {
                    return null;
                  }
                },
                onSaved: (girilenEmail){
                  _juriEmail = girilenEmail;
                },
              ),
              SizedBox(height: 10),
              // Juri Şifre
              TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Şifre",
                labelText: "Şifre",
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
              onSaved: (girilenSifre){
                _juriPassword = girilenSifre;
              },
            ),
              SizedBox(height: 10),
              // Juri meslek
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Juri Meslek",
                  labelText: "Juri Meslek",
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
                onSaved: (girilenMeslek){
                  _jurimeslek = girilenMeslek;
                },
              ),
              SizedBox(height: 10),
              // GirişButonu
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                icon: Icon(Icons.save,color: Colors.white,),
                label: Text("Kaydet",style: TextStyle(color: Colors.white),),
                onPressed: _emailSifreKullaniciOlustur,
                color: Colors.blueAccent,
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _emailSifreKullaniciOlustur() async {
    //debugPrint(widget._auth.toString());
    juriKey.currentState.save();
    Map<String, dynamic> juri = Map();
    juri['Juri Email'] = _juriEmail;
    juri['Juri Sifre'] = _juriPassword;
    juri['Juri Ad'] = _juriAd;
    juri['Juri Soyad'] = _juriSoyad;
    juri['Juri Meslek'] = _jurimeslek;

    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(email: _juriEmail, password: _jurimeslek);
      //User _newUser = _credential.user;
      //debugPrint(_newUser.toString());
      //await _newUser.sendEmailVerification();
      //debugPrint("Size bir e mail yolladık lütfen onaylayın");
      // FireBase ekleme işlemleri
      await _firebaseFirestore.collection('jüriler').doc(_juriEmail).set(juri).then((value) => "Yazma işlemi başarılı");
      _showDialog();
    } catch (e) {
      debugPrint("**************HATA VAR!!!************");
      debugPrint(e.toString());
    }
  }
  void _showDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Kayıt Ol"),
            content: Text("Kayıt işlemi başarılı"),
            actions: <Widget>[
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                  child: Text("Tamam")),
            ],
          );
        }
    );
  }

}
