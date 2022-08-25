// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  const MenuPage({Key? key}) : super(key: key);
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          backgroundColor: baseColor1,
          title: const Text(''),
          elevation: 0,
          actions: const <Widget>[],
        ),
        body: Stack(children: <Widget>[
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
          Positioned(
            top: 20,
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                        
                          child: const Text(
                            'ระบบบริหารจัดการรถยนต์',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: ('IBM Plex Sans Thai'),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'VDQI Stock Management',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: ('IBM Plex Sans Thai'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SingleChildScrollView(
                        child:  SizedBox(
                          height: 500,
                          child: Card(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          
                            child: GridView.count(
                            padding: EdgeInsets.all(5.0),
                              crossAxisCount: 1,
                               childAspectRatio: (1 / .3),
                              crossAxisSpacing: 4.0,  
                              mainAxisSpacing: 8.0,
                              children: <Widget>[
                                Card(
                                  
                                  margin: EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () { },
                                    splashColor: Colors.red,
                                    child: Center(
                                        child: Column(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                         const SizedBox(height: 20),
                                           Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 100.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("ค้นหารถยนต์ ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: ('IBM Plex Sans Thai'),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                         Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 100.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Find My Car ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: ('IBM Plex Sans Thai'),
                                                
                                              )),
                                        ),
                                      ),
                                        
                                      ],
                                    )),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () { },
                                    splashColor: Colors.red,
                                    child: Center(
                                        child: Column(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                         const SizedBox(height: 20),
                                           Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 100.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("เพิ่มรถยนต์ใหม่ ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: ('IBM Plex Sans Thai'),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                         Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 100.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Add New Car ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: ('IBM Plex Sans Thai'),
                                                
                                              )),
                                        ),
                                      ),
                                        
                                      ],
                                    )),
                                  ),
                                ),

                              ],
                            ),
                          )),
                        

                      ),
                      const SizedBox(height: 10),
                      Container(
                        child: const Text(
                          'Powered by Weise Technika',
                          style:
                              TextStyle(fontSize: 11, color: Color.fromARGB(255, 228, 223, 223),fontFamily: ('IBM Plex Sans Thai'),
                              ),
                        ),
                      ),
                    ])),
          )
        ]));
  }
}
