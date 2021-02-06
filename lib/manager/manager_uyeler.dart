import 'package:flutter/material.dart';


class ManagerUyeEkran extends StatefulWidget {
  @override
  _ManagerUyeEkranState createState() => _ManagerUyeEkranState();
}

class _ManagerUyeEkranState extends State<ManagerUyeEkran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Üyeler"),
      ),
      body: Container(
        child: Text("Manager Üyeleri Görüntüle"),
      ),
    );
  }
}