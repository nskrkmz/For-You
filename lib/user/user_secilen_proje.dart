import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/Proje.dart';
import 'package:flutter_foru/user/user_bottom_tamamlanan_projeler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UserSecilenProje extends StatefulWidget {
  FirebaseAuth firebaseAuthUser;
  Proje secilenProjeler;
  UserSecilenProje({this.firebaseAuthUser, this.secilenProjeler});

  @override
  _UserSecilenProjeState createState() => _UserSecilenProjeState();
}

class _UserSecilenProjeState extends State<UserSecilenProje> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Map<String, dynamic> tamamlanmisProjeler = Map();
  final picker = ImagePicker();
  File _imageFile;

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
            //Proje ayrıntıları
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepOrange,Colors.pink.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
                    border: Border.all(color: Colors.purple,width: 3),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(widget.secilenProjeler.projeAyrtintilari,style: TextStyle(fontFamily:'GovdeFont',color: Colors.white,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10),
            // Proje süresi
            Container(
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepOrange,Colors.pink.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                border: Border.all(color: Colors.purple,width: 3),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0)),
              ),
              child: Text("Proje Süresi: ${widget.secilenProjeler.projeSuresi}" + "  Proje Puanı: ${widget.secilenProjeler.projeOdul}",style: TextStyle(fontFamily:'GovdeFont',color: Colors.white,fontWeight: FontWeight.bold) ),

            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: (_imageFile != null) ? Image.file(_imageFile) : resimSec(),
            ),
            RaisedButton(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Text("Seçimi Temizle",style: TextStyle(color: Colors.white),),
              onPressed: (){
                  setState(() {
                    _imageFile = null;
                  });
              },
            ),
            RaisedButton(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              onPressed: () => uploadImageToFirebase(context),
              child: Text("Yükle",style: TextStyle(color: Colors.white),),
            ),
            RaisedButton(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Text("Tamam",style: TextStyle(color: Colors.white),),
              onPressed: (){
                if(_imageFile == null){
                  _showDialogUyari(context);
                }else{
                  _firebaseFirestore.collection('Tamamlanmış Projeler').doc('${widget.secilenProjeler.projeBaslik}').set(projeGonder());
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> projeGonder (){
    //debugPrint(widget.secilenProjeler.projeBaslik);
    //debugPrint(widget.secilenProjeler.projeSuresi);
    //debugPrint(widget.firebaseAuthUser.currentUser.email);
    tamamlanmisProjeler['Proje Baslığı'] = widget.secilenProjeler.projeBaslik;
    tamamlanmisProjeler['Proje Suresi'] = widget.secilenProjeler.projeSuresi;
    tamamlanmisProjeler['Proje Odul'] = widget.secilenProjeler.projeOdul;
    tamamlanmisProjeler['Projeyi Tamamlayan'] = widget.firebaseAuthUser.currentUser.email;
    return tamamlanmisProjeler;

  }

  Widget resimSec(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            FlatButton(
              child: Icon(
                Icons.add_a_photo,
                size: 50,
              ),
              onPressed: pickImageCamera,
            ),
            Text("Resim Çek"),
          ],
        ),
        Column(
          children: <Widget>[
            FlatButton(
              child: Icon(
                Icons.add_a_photo,
                size: 50,
              ),
              onPressed: pickImageGallery,
            ),
            Text("Galeriden Resim Seç")
          ],
        )
      ],
    );
  }
  Future pickImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }
  Future pickImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => "");
    taskSnapshot.ref.getDownloadURL().then(
          (value) {
            print("Done: $value");
            _showDialogYukleme(context);
          }
    );
  }

  void _showDialogUyari(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Seçim Yap"),
            content: Text("Lütfen Resim Ekleyiniz"),
            actions: <Widget>[
              FlatButton(
                child: Text("Tamam"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
  void _showDialogYukleme(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Yükleme"),
            content: Text("Yükleme Başarıyla Tamamlandı"),
            actions: <Widget>[
              FlatButton(
                child: Text("Tamam"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }


}
