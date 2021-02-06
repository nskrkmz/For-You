import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/manager/manager_bottom_ilkekran.dart';
import 'package:flutter_foru/manager/manager_bottom_juriler.dart';
import 'package:flutter_foru/manager/manager_bottom_profile.dart';
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
  ManagerProfileEkran _profileEkran;

  @override
  void initState() {
    super.initState();
    _ilkEkran = ManagerIlkEkran();
    _juriEkran = ManagerJuriEkran();
    _profileEkran = ManagerProfileEkran();
    tumSayfalar = [_ilkEkran, _juriEkran, _profileEkran];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ManagerDrawerMenu(firebaseAuthYonetici: widget.firebaseAuthManager,),
      appBar: AppBar(
        title: Text("Manager Home Page"),
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
        canvasColor: Colors.indigo,
        primaryColor: Colors.white,
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // button active olduğunda kullanılacak icon
              //activeIcon: Icon(Icons.call),
              label: "Ana sayfa",
              backgroundColor: Colors.indigoAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Jüriler",
              backgroundColor: Colors.deepOrange),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil Ayarları",
              backgroundColor: Colors.deepOrange),
        ],
        type: BottomNavigationBarType.shifting,
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
