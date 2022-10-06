import 'package:flutter/material.dart';
import 'package:vdqims/Page/AddnewcarPage/AddnewcarPage.dart';
import 'package:vdqims/Page/FindcarPage/FindcarPage.dart';
import 'package:vdqims/Page/HomePage/HomePage.dart';
import 'package:vdqims/Page/LoginPage/LoginPage.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';
import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import 'package:vdqims/Service/API/AuthAPI.dart';
import 'package:vdqims/SplashScreen/MainSplash.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
/*   bool _isLoggedIn = false; */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const AddnewcarPage(),
    );
  }
}
