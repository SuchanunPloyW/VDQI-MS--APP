import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';

import '../Style/TextStyle.dart';

class Reqsplash extends StatefulWidget {
  const Reqsplash({super.key});

  @override
  State<Reqsplash> createState() => _ReqsplashState();
}

class _ReqsplashState extends State<Reqsplash> {
   Color baseColor1 = const Color(0xffE52628);
    Color baseColor2 = const Color(0xffA10002);
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  MycarsPage()));
              });

  }
  @override
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
                  "ทำการเบิกรถยนต์สำเร็จ",
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