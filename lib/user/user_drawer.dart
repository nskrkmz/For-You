import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class UserDrawerMenu extends StatefulWidget {
  FirebaseAuth firebaseAuthUser;
  UserDrawerMenu({this.firebaseAuthUser});
  @override
  _UserDrawerMenuState createState() => _UserDrawerMenuState();
}

class _UserDrawerMenuState extends State<UserDrawerMenu> {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Enes Korkmaz"), // değişkene atanacak
            accountEmail: Text("enes@hotmail.com"), //değişkene atılacak
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/ekran2.png"),
                ),
                shape: BoxShape.circle,
                //resim asset eklenecek
              ),
            ),
          ),
          InkWell(
            onTap: (){
              //Navigator.pushNamed(context, "/sayfa")
            },
            highlightColor: Colors.blue,
            child: ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text("Sayfa Adı"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          InkWell(
            onTap: (){
              //Navigator.pushNamed(context, "/sayfa")
            },
            highlightColor: Colors.blue,
            child: ListTile(
              leading: Icon(Icons.power_settings_new_outlined),
              title: Text("Çıkış Yap"),
              trailing: Icon(Icons.arrow_forward),
              onTap: _showDialog,
            ),
          ),
        ],
      ),
    );
  }
  void _cikisYap() async {
    try {
      if (widget.firebaseAuthUser.currentUser != null) {
        debugPrint("${widget.firebaseAuthUser.currentUser.email} çıkış yapıyor...");
        await widget.firebaseAuthUser.signOut();
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
