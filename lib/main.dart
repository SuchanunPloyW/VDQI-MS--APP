import 'package:flutter/material.dart';
import 'package:vdqims/Page/HomePage/HomePage.dart';

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
         fontFamily: 'Poppins',
         textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
      home :HomePage() ,
      
    );
  }
}
