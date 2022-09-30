

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';

import '../Page/MycarsPage/MycarsPage.dart';
import '../Style/TextStyle.dart';

class AddnewSplash extends StatefulWidget {
  const AddnewSplash({super.key});

  @override
  State<AddnewSplash> createState() => _AddnewSplashState();
}

class _AddnewSplashState extends State<AddnewSplash> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MenuPage()),
          (Route<dynamic> route) => false);
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
                Lottie.asset('assets/images/correct.json',
                height: 200,
                width: 200
                ),
                SizedBox(height: 30,),
                
                 Text(
                  "ทำการเพิ่มรถยนต์สำเร็จ",
                  textAlign: TextAlign.center,
                  style: TextStyleSplash.body
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}