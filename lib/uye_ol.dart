import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class UyeOl extends StatefulWidget {
  FirebaseAuth _auth;
  UyeOl(this._auth);
  @override
  _UyeOlState createState() => _UyeOlState();
}

class _UyeOlState extends State<UyeOl> {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Color color1 = const Color(0xFFEA4C4D);
  Color color2 = const Color(0xFFEDB758);

  String _kullaniciAd = "default";
  String _kullaniciSoyad = "default";
  String _kullaniciEmail = "default";
  String _kullaniciPassword = "default";
  String _kullaniciUniversite = "default";
  String _kullaniciBolum = "default";

  var uyeOlKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.pink.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Form(
          key: uyeOlKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: <Widget>[
              // Kullanıcı ad
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Ad",
                  labelText: "Ad",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (girilenAd){
                  _kullaniciAd = girilenAd;
                },
              ),
              SizedBox(height: 10),
              // Kullanıcı Soyad
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Soyad",
                  labelText: "Soyad",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (girilenSoyad){
                  _kullaniciSoyad = girilenSoyad;
                },
              ),
              SizedBox(height: 10),
              // Kullanıcı Universite
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Universite",
                  labelText: "Universite",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (girilenUni){
                  _kullaniciUniversite = girilenUni;
                },
              ),
              SizedBox(height: 10),
              // Kullanıcı Bolum
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Bolum",
                  labelText: "Bolum",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (girilenBolum){
                  _kullaniciBolum = girilenBolum;
                },
              ),
              SizedBox(height: 10),
              //Email giriş
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
                ),
                validator: (String girilenVeri){
                  if (!(girilenVeri.contains("@gmail.com")|| girilenVeri.contains("@hotmail.com") || girilenVeri.contains("@outlook.com") || girilenVeri.contains("@bil.omu.edu.tr"))){
                    return "Lütfen geçerli bir e mail giriniz";
                  }else {
                    return null;
                  }
                },
                onSaved: (girilenEmail){
                  _kullaniciEmail = girilenEmail;
                },
              ),
              SizedBox(height: 10),
              //Şifre Giriş
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
                ),
                validator: (String girilenVeri){
                  if(girilenVeri.length <= 6 ){
                    return "Şifre 6 karakterden az olamaz";
                  }else{
                    return null;
                  }
                },
                onSaved: (girilenSifre){
                  _kullaniciPassword = girilenSifre;
                },
              ),
              SizedBox(height: 10),
              // GirişButonu
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                icon: Icon(Icons.arrow_forward,color: Colors.white,),
                label: Text("Kayıt Ol",style: TextStyle(color: Colors.white),),
                onPressed: _emailSifreKullaniciOlustur,
                color: Colors.purple,
              ),

            ],
          ),
        ),
      ),
    );
  }
  void _emailSifreKullaniciOlustur() async {
    //debugPrint(widget._auth.toString());
    uyeOlKey.currentState.save();
    Map<String, dynamic> kullanici = Map();
    kullanici['Email'] = _kullaniciEmail;
    kullanici['Sifre'] = _kullaniciPassword;
    kullanici['Ad'] = _kullaniciAd;
    kullanici['Soyad'] = _kullaniciSoyad;
    kullanici['Universite'] = _kullaniciUniversite;
    kullanici['Bolum'] = _kullaniciBolum;


    try {
      UserCredential _credential = await widget._auth.createUserWithEmailAndPassword(email: _kullaniciEmail, password: _kullaniciPassword);
      //User _newUser = _credential.user;
      //debugPrint(_newUser.toString());
      //await _newUser.sendEmailVerification();
      //debugPrint("Size bir e mail yolladık lütfen onaylayın");
      // FireBase ekleme işlemleri
      await _firebaseFirestore.collection('users').doc(_kullaniciEmail).set(kullanici).then((value) => "Yazma işlemi başarılı");
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
