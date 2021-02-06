import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/user/user_ayarlar.dart';
import 'package:flutter_foru/user/user_drawer.dart';
import 'package:flutter_foru/user/user_bottom_projeler.dart';

class UserHomePage extends StatefulWidget {
  //FirebaseAuth işlemleri yapılacak
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int secilenMenuItem = 0 ;
  List<Widget> tumSayfalar ;
  UserProjectPage projeEkrani ;
  UserAyarlar ayarlarEkrani ;

  @override
  void initState() {

    super.initState();
    projeEkrani = UserProjectPage();
    ayarlarEkrani = UserAyarlar();
    tumSayfalar = [projeEkrani, ayarlarEkrani];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: UserDrawerMenu(),
      appBar: AppBar(
        title: Text("Projeler"),
        centerTitle: true,
      ),
      body: tumSayfalar[secilenMenuItem],
      bottomNavigationBar: bottomNavMenu(),
    );
  }

  Theme bottomNavMenu (){
    return Theme(
      data: ThemeData(
        canvasColor: Colors.indigo,
        primaryColor: Colors.white,
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.pages_rounded),
              // button active olduğunda kullanılacak icon
              //activeIcon: Icon(Icons.call),
              label: "Projeler",
              backgroundColor: Colors.indigoAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Ayarlar",
              backgroundColor: Colors.deepOrange),

        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: secilenMenuItem,
        onTap: (index){
          setState(() {
            secilenMenuItem=index;
          });
        },
      ),
    );
  }
}