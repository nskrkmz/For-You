import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/manager_bottom_ilkekran.dart';
import 'package:flutter_foru/manager/manager_bottom_juriler.dart';
import 'package:flutter_foru/manager/manager_drawer.dart';


class ManagerHomePage extends StatefulWidget {
  FirebaseAuth firebaseAuthManager;
  ManagerHomePage({this.firebaseAuthManager});
  @override
  _ManagerHomePageState createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {

  int secilenmenuItem = 0;
  List<Widget> tumSayfalar;
  ManagerIlkEkran _ilkEkran;
  ManagerJuriEkran _juriEkran;

  @override
  void initState() {
    super.initState();
    _ilkEkran = ManagerIlkEkran();
    _juriEkran = ManagerJuriEkran();
    tumSayfalar = [_ilkEkran, _juriEkran];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ManagerDrawerMenu(firebaseAuthYonetici: widget.firebaseAuthManager,),
      appBar: AppBar(
        title: (secilenmenuItem == 0) ? Text("Yayınlanan Projeler") : Text("Kayıtlı Jüriler"),
        centerTitle: true,
      ),
      body: tumSayfalar[secilenmenuItem],
      bottomNavigationBar: bottomNavMenu(),
    );
  }
  Theme bottomNavMenu() {
    return Theme(
      data: ThemeData(
        // bottom bar button ların renklerinin değiştirilmesi
        //primarySwatch: Colors.red,
        canvasColor: Colors.purple,
        primaryColor: Colors.white,
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.pages),
              label: "Ana sayfa",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Jüriler",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: secilenmenuItem,
        onTap: (index) {
          setState(() {
            secilenmenuItem = index;
          });
        },
      ),
    );
  }

}
