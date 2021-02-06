import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foru/login_islemleri.dart';
import 'package:flutter_foru/manager/manager_homepage.dart';
import 'package:flutter_foru/manager/manager_juri_islemleri.dart';
import 'package:flutter_foru/manager/manager_proje_islemleri.dart';
import 'package:flutter_foru/manager/manager_uyeler.dart';

import 'user/user_homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/" : (context) => App(),
        "/DrawerProjeislemleri" : (context) => ManagerProjeIslemleri(),
        "/DrawerJuriislemleri" : (context) => ManagerJuriIslemleri(),
        "/DrawerUyeislemleri" : (context) => ManagerUyeEkran(),
        "/Login" : (context) => LoginIslemleri(),

      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("HATA !!!:" + snapshot.error.toString()),
            ),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done){
          return LoginIslemleri();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
