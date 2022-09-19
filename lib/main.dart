

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vdqims/Page/AddnewcarPage/AddnewcarPage.dart';
import 'package:vdqims/Page/FindcarPage/FindcarPage.dart';
import 'package:vdqims/Page/HomePage/HomePage.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';
import 'package:vdqims/Test/Test.dart';

import 'Page/LoginPage/LoginPage.dart';


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
      home: const SplashScreen(),
    );
  }
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      
      splash: Lottie.asset('assets/images/loadingcircles.json'),
      backgroundColor: Colors.red,
      nextScreen: const MenuPage(),
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      
      
    );
    
    
  }
}

