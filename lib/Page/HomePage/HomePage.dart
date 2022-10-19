// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';

import '../../Style/TextStyle.dart';
import '../Widget/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  const HomePage({Key? key}) : super(key: key);
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
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
                  ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: AutoSizeText(
                                  'หน้าหลัก',
                                  style: TextStyleMenuName.bodyMenuThai,
                                  maxFontSize: 18,
                                  minFontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                'Home Page',
                                style: TextStyleMenuName.bodyMenuEng,
                                maxLines: 1,
                                minFontSize: 14,
                                maxFontSize: 16,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                  height: 450,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
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
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.05),
                                              blurRadius: 12,
                                              /*   offset: Offset(0, 3), */
                                            ),
                                          ]),
                                      child: GridView.count(
                                        padding: EdgeInsets.all(5.0),
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 8.0,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                left: 5,
                                                right: 5,
                                                bottom: 5),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                     Future.delayed(
                                                        Duration(
                                                            milliseconds: 300),
                                                        () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  MenuPage()));
                                                    });
                                                    
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                   shadowColor: Colors.grey,
                                                  // background
                                                  onPrimary: Color.fromARGB(
                                                      255, 224, 197, 197),
                                                  padding: EdgeInsets.all(15),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    12),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12)),
                                                  )),
                                                  child: Column(children: [
                                                    const SizedBox(
                                                          height: 10),
                                                      Image.asset(
                                                        'assets/images/car1.png',
                                                        height: 70.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      Text(
                                                        'ระบบบริหารจัดการสต๊อครถยนต์',
                                                        style: TextStylePage
                                                            .bodyP10,
                                                        maxLines: 1,
                                                        textScaleFactor: 1,
                                                      ),
                                                      Text(
                                                        'VDQI Stock Management',
                                                        style: TextStylePage
                                                            .bodyP10,
                                                        maxLines: 1,
                                                        textScaleFactor: 1,
                                                      )

                                                  ]),
                                                ),
                                           /*  child: Container(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    12),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.1),
                                                        blurRadius: 12,
                                                        /*   offset: Offset(0, 3), */
                                                      ),
                                                    ]),
                                                child: InkWell(
                                                  onTap: () {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 300),
                                                        () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  MenuPage()));
                                                    });
                                                  },
                                                  splashColor: Colors.red,
                                                  child: Center(
                                                      child: Column(
                                                    children: <Widget>[
                                                      const SizedBox(
                                                          height: 15),
                                                      Image.asset(
                                                        'assets/images/car1.png',
                                                        height: 80.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
                                                      Text(
                                                        'ระบบบริหารจัดการสต๊อครถยนต์',
                                                        style: TextStylePage
                                                            .bodyP10,
                                                        maxLines: 1,
                                                        textScaleFactor: 1,
                                                      ),
                                                      Text(
                                                        'VDQI Stock Management',
                                                        style: TextStylePage
                                                            .bodyP10,
                                                        maxLines: 1,
                                                        textScaleFactor: 1,
                                                      )
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ), */
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                left: 5,
                                                right: 5,
                                                bottom: 5),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.grey,
                                                  primary: Colors.white,
                                                  // background
                                                  onPrimary: Color.fromARGB(
                                                      255, 224, 197, 197),
                                                  padding: EdgeInsets.all(15),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    12),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12)),
                                                  )),
                                              child: InkWell(
                                                child: Center(
                                                  child: Column(children: [
                                                    const SizedBox(height: 10),
                                                    Image.asset(
                                                      'assets/images/setting.png',
                                                      height: 70.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                      'ตั้งค่าการใช้งาน',
                                                      style:
                                                          TextStylePage.bodyP10,
                                                      maxLines: 1,
                                                      textScaleFactor: 1,
                                                    ),
                                                    Text(
                                                      'Setting',
                                                      style:
                                                          TextStylePage.bodyP10,
                                                      maxLines: 1,
                                                      textScaleFactor: 1,
                                                    )
                                                  ]),
                                                ),
                                              ),
                                            ),
                                        
                                          ),

                                          
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Powered by Weise Technika',
                            style: TextStyleFoot.bodyfoot,
                            textScaleFactor: 1,
                          ),
                        ])),
              ),
            )
          ]),
        ));
  }
}
