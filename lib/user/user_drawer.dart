import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class UserDrawerMenu extends StatefulWidget {
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
              leading: Icon(Icons.arrow_back),
              title: Text("Sayfa Adı"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
