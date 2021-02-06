import 'package:flutter/material.dart';


class ManagerJuriIslemleri extends StatefulWidget {
  @override
  _ManagerJuriIslemleriState createState() => _ManagerJuriIslemleriState();
}

class _ManagerJuriIslemleriState extends State<ManagerJuriIslemleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jüri İşlemleri"),
      ),
      body: Container(
        child: Text("Manager Juri islemleri"),
      ),
    );
  }
}