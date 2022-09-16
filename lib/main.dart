import 'package:flutter/material.dart';
import 'package:vdqims/Page/AddnewcarPage/AddnewcarPage.dart';
import 'package:vdqims/Page/CardetailPage/CardetailPage.dart';
import 'package:vdqims/Page/CheckinPage/CheckinPage.dart';
import 'package:vdqims/Page/FindcarPage/FindcarPage.dart';
import 'package:vdqims/Page/HomePage/HomePage.dart';
import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import 'package:vdqims/Page/ProfilePage/ProfilePage.dart';


import 'Page/LoginPage/LoginPage.dart';
import 'Page/MenuPage/MenuPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
/*   bool _isLoggedIn = false; */

  @override
  /* void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
  void _checkIfLoggedIn() async{
      // check if token is there
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      if(token!= null){
         setState(() {
            _isLoggedIn = true;
         });
      }
  } */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'IBM Plex Sans Thai',
        textTheme: const TextTheme(
          /* titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ), */
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MycarsPage(),
    );
  }
}
