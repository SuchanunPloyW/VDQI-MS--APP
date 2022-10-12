import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vdqims/Page/HomePage/HomePage.dart';
import 'package:vdqims/Page/LoginPage/LoginPage.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';

class MainSplash1 extends StatefulWidget {
  const MainSplash1({super.key});

  @override
  State<MainSplash1> createState() => _MainSplash1State();
}

class _MainSplash1State extends State<MainSplash1> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors: [baseColor1, baseColor2]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Lottie.asset('assets/images/loadingcircles.json', height: 400, width: 400),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
