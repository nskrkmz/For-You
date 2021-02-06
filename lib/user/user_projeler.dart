import 'package:flutter/material.dart';
import 'package:flutter_foru/user/user_drawer.dart';

class UserProjectPage extends StatefulWidget {
  @override
  _UserProjectPageState createState() => _UserProjectPageState();
}

class _UserProjectPageState extends State<UserProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawerMenu(),
      appBar: AppBar(
        title: Text("aaaaaaaaaaa"),
        centerTitle: true,
      ),
      body: Container(
        child: Text("yazı"),
      ),
    );
  }
}