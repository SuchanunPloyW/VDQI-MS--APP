
import 'package:flutter/material.dart';
import 'package:vdqims/Page/LoginPage/LoginPage.dart';

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
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
       /*  fontFamily: 'Kanit', */
        textTheme: const TextTheme(
          /* titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ), */
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainSplash(),
    );
  }
}
/* class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      
      splash: Lottie.asset('assets/images/loadingcircles.json'),
      backgroundColor: Colors.red,
      nextScreen:  MycarsPage(),
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      
      
    );
    
    
  }
} */

