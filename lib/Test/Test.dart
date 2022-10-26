import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Page/MenuPage/MenuPage.dart';
import '../Style/TextStyle.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "ข้อมูลส่วนตัว",
                style: TextStyleMenuName.bodyMenuThai,
                children: <TextSpan>[
                  TextSpan(
                      text: '\nProfile', style: TextStyleMenuName.bodyMenuEng),
                ])),
        leading: IconButton(
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const MenuPage()));
            });
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_sharp,
            size: 30,
          ),
        ),
        backgroundColor: baseColor1,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  // alignment: AlignmentDirectional.center,
                  height: 290.h,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    stops: const [0.0, 2.0],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [baseColor1, baseColor2],
                  )),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 72,
                            child: CircleAvatar(
                              radius: 70.0,
                              child: ClipRRect(
                                child: Image.asset('assets/images/Profile.png'),
                                borderRadius: BorderRadius.circular(70.0),
                              ),
                            )),
                      ),
                    ],
                  ))),
              SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: SizedBox(
                        height: 400.h,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.05),
                                      blurRadius: 12,
                                      /*   offset: Offset(0, 3), */
                                    ),
                                  ]),
                            )))),
              )
            ],
          );
        },
      ),
    );
  }
}
