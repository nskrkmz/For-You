import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ManagerDrawerMenu extends StatefulWidget {
  FirebaseAuth firebaseAuthYonetici;
  ManagerDrawerMenu({this.firebaseAuthYonetici});
  @override
  _ManagerDrawerMenuState createState() => _ManagerDrawerMenuState();
}

class _ManagerDrawerMenuState extends State<ManagerDrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Burak Aksu"),
            accountEmail: Text("brk.aksu60@gmail.com\n(Yönetici)"),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/ekran2.png"),
                  )
              ),
            ),
          ),
          //Proje islemleri
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/DrawerProjeislemleri");
            },
            highlightColor: Colors.blue,
            child: ListTile(
              leading: Icon(Icons.pages_rounded),
              title: Text("Proje islemleri"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          // Yayınlanmış Projeler
          InkWell(
            onTap: (){
              //Navigator.pushNamed(context, "/DrawerProjeislemleri");
            },
            highlightColor: Colors.blue,
            child: ListTile(
              leading: Icon(Icons.pages_outlined),
              title: Text("Yayınlanmış Projeler"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          // Jüri islemleri
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/DrawerJuriislemleri");
            },
            highlightColor: Colors.blue,
            //splashColor: Colors.red,
            child: ListTile(
              leading: Icon(Icons.people),
              title: Text("Jüri işlemleri"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          // Üye islemleri
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/DrawerUyeislemleri");
            },
            highlightColor: Colors.blue,
            //splashColor: Colors.red,
            child: ListTile(
              leading: Icon(Icons.people_outline),
              title: Text("Üyeler"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          // Çıkıs yap
          InkWell(
            onTap: _showDialog,
            highlightColor: Colors.blue,
            //splashColor: Colors.red,
            child: ListTile(
              leading: Icon(Icons.power_settings_new_outlined),
              title: Text("Çıkış Yap"),
            ),
          ),
        ],
      ),
    );
  }

  void _cikisYap() async {
    try {
      if (widget.firebaseAuthYonetici.currentUser != null) {
        debugPrint("${widget.firebaseAuthYonetici.currentUser.email} çıkış yapıyor...");
        await widget.firebaseAuthYonetici.signOut();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, "/Login");
      } else {
        // sistemde zaten bir kullanıcı yoksa sorun yok
        debugPrint("Zaten oturum açmış bir kullanıcı yok");
      }
    } catch (e) {
      debugPrint("HATA!:" + e.toString());
    }
  }

  void _showDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Çıkış Yap"),
            content: Text("Emin misiniz?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Evet"),
                onPressed: _cikisYap,
              ),
              FlatButton(
                child: Text("Hayır"),
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