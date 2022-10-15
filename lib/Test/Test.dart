import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Page/AddnewcarPage/AddnewcarPage.dart';
import '../Page/FindcarPage/FindcarPage.dart';
import '../Page/MycarsPage/MycarsPage.dart';
import '../Page/Widget/drawer.dart';
import '../Style/ColorTheme.dart';
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
    final textscale = MediaQuery.of(context).textScaleFactor;
    print(textscale);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CircleAvatar(
                radius: 20.0,
                child: ClipRRect(
                  child: Image.asset('assets/images/Profile.png'),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
          backgroundColor: baseColor1,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                'assets/images/iconMenu.png',
                height: 16.00,
                width: 26.67,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: SideMenu(),
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  // alignment: AlignmentDirectional.center,
                  height: 298,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    stops: const [0.0, 2.0],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [baseColor1, baseColor2],
                  ))
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Text('ระบบบริหารจัดการรถยนต์', 
                            style: TextStyleMenuName.bodyMenuThai),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('VDQI Stock Management', style: TextStyleMenuName.bodyMenuEng),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                              height: 450,
                              child: Card(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                margin: const EdgeInsets.only(left: 10, right: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: GridView.count(
                                  padding: EdgeInsets.all(5.0),
                                  crossAxisCount: 1,
                                  childAspectRatio: (1 / .3),
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 1.0,
                                  children: <Widget>[
                                    //------------------------------- ค้นหา  -----------------------------------
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xffFFFFFF), // background
                                              onPrimary: Color.fromARGB(255, 224, 197, 197),
                                              padding: EdgeInsets.all(20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              )),
                                          child: Row(children: [
                                            Container(
                                              child: Image.asset(
                                                'assets/images/car2.png',
                                                height: 45.0,
                                                width: 45,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Expanded(
                                                child: Text(' ค้นหารถยนต์ \n Find My Car',
                                                     style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      color: ColorTheme.bold,
                                                      fontFamily: ('Bai Jamjuree'),
                                                      fontSize: 16 * textscale


                                                     ))),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xffDDDDDD),
                                            )
                                          ]),
                                          onPressed: () {
                                            Future.delayed(Duration(milliseconds: 500), (() {
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => FindcarPage()));
                                            }));
                                          },
                                        )),

                                    //------------------------------- ค้นหา  -----------------------------------
                                    //------------------------------- เพิ่มรถ  -----------------------------------
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xffFFFFFF), // background
                                              onPrimary: Color.fromARGB(255, 224, 197, 197),
                                              padding: EdgeInsets.all(20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              )),
                                          child: Row(children: [
                                            Container(
                                              child: Image.asset(
                                                'assets/images/plus.png',
                                                height: 45.0,
                                                width: 45,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Expanded(
                                                child: Text(' เพิ่มรถยนต์ใหม่ \n Add New Car',
                                                    style: TextStylePage.bodyP16)),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xffDDDDDD),
                                            )
                                          ]),
                                          onPressed: () {
                                            Future.delayed(Duration(milliseconds: 500), (() {
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => AddnewcarPage()));
                                            }));
                                          },
                                        )),

                                    //------------------------------- เพิ่มรถ  -----------------------------------
                                    //------------------------------- รถยนต์ของฉัน  -----------------------------------
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              // ignore: deprecated_member_use
                                              primary: Color(0xffFFFFFF), // background
                                              onPrimary: Color.fromARGB(255, 224, 197, 197), // foreground
                                              padding: EdgeInsets.all(20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              )),
                                          child: Row(children: [
                                            Container(
                                              child: Image.asset(
                                                'assets/images/car3.png',
                                                height: 45.0,
                                                width: 45,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Expanded(
                                                child: Text(' รถยนต์ของฉัน \n My Cars',
                                                   style: TextStylePage.bodyP16)),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xffDDDDDD),
                                            )
                                          ]),
                                          onPressed: () {
                                            Future.delayed(Duration(milliseconds: 500), (() {
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => MycarsPage()));
                                            }));
                                          },
                                        )),
                                    //------------------------------- เบิกรถ  -----------------------------------
                                  ],
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Powered by Weise Technika', style: TextStyleFoot.bodyfoot),
                    ])),
              ),
            )
          ]),
        ));
  }
}