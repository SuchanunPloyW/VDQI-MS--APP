import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vdqims/Page/LoginPage/LoginPage.dart';


class MainSplash extends StatefulWidget {
  const MainSplash({super.key});

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
    Color baseColor1 = const Color(0xffE52628);
    Color baseColor2 = const Color(0xffA10002);
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginPage()));
              });

  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
               baseColor1, baseColor2
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Lottie.asset('assets/images/loadingcircles.json',
                height: 400,
                width: 400
                ),
             const CircularProgressIndicator( 
              valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),
            ),
              ],
            ),
            
          ],
        ),
        
      ),
      
    );
  }
}