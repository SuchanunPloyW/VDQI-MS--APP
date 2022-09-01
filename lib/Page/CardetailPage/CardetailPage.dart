// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vdqims/Page/FindcarPage/FindcarPage.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';

import '../FindcarPage/Model/FindcarModel.dart';
//import '../MenuPage/MenuPage.dart';

class CardetailPage extends StatefulWidget {
  const CardetailPage({Key? key, required this.model}) : super(key: key);
  final CarAPI model;
  State<CardetailPage> createState() => _CardetailPageState();
}

class _CardetailPageState extends State<CardetailPage> {
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
                  text: "รายละเอียดรถยนต์",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: ('IBM Plex Sans Thai'),
                    fontWeight: FontWeight.bold,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text: '\nCar Infomation',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: ('IBM Plex Sans Thai'),
                      ),
                    ),
                  ])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(Duration(milliseconds: 200), () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FindcarPage()));
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 30,
            ),
          ),
          backgroundColor: baseColor1,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                // alignment: AlignmentDirectional.center,
                height: 290,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  stops: const [0.0, 2.0],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [baseColor1, baseColor2],
                )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Positioned(
                  top: 80,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height: 650,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(children: <Widget>[
                                        /* Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10), ), */
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Color(0xffF6F6F6),
                                                  blurRadius: 20,
                                                  offset: Offset(5, 5),
                                                ),
                                              ],
                                            ),
                                            height: 100.0,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: ListTile(
                                                title: Text(
                                                  widget.model.carChassis,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        ('IBM Plex Sans Thai'),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                leading: CircleAvatar(
                                                  child: ClipRRect(
                                                    child: Image.asset(
                                                      'assets/images/car4.png',
                                                      height: 28.0,
                                                      width: 30,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                  ),
                                                  radius: 32.0,
                                                  backgroundColor:
                                                      Color(0xff89EB80),
                                                ),
                                                subtitle: Text(
                                                  'Yaris Ativ 1.2 G \nสถานะ : ว่าง',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        ('IBM Plex Sans Thai'),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Color(0xffF6F6F6),
                                                  blurRadius: 20,
                                                  offset: Offset(5, 5),
                                                ),
                                              ],
                                            ),
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: GestureDetector(
                                                    onTap: () =>
                                                        FocusScope.of(context)
                                                            .unfocus(),
                                                    child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, -0.1),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Container(
                                                              height: 159,
                                                              child: Stack(
                                                                  children: [
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -0.9,
                                                                          -0.9),
                                                                      child: Text(
                                                                          'สถานที่',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xffD4D4D4),
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                ('IBM Plex Sans Thai'),
                                                                          )),
                                                                    ),
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -0.05,
                                                                          -0.59),
                                                                      child: Text(
                                                                          widget
                                                                              .model
                                                                              .carWhere
                                                                              .carWhere,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xff404040),
                                                                            fontSize:
                                                                                40,
                                                                            fontFamily:
                                                                                ('IBM Plex Sans Thai'),
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          )),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -0.9,
                                                                              0.1),
                                                                      child: Text(
                                                                          'แถว',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xffD4D4D4),
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                ('IBM Plex Sans Thai'),
                                                                          )),
                                                                    ),
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -0.56,
                                                                          0.7),
                                                                      child: Text(
                                                                          'A',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xff404040),
                                                                            fontSize:
                                                                                40,
                                                                            fontFamily:
                                                                                ('IBM Plex Sans Thai'),
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          )),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.1,
                                                                              0.1),
                                                                      child: Text(
                                                                          'ลำดับ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                ('IBM Plex Sans Thai'),
                                                                            color:
                                                                                Color(0xffD4D4D4),
                                                                          )),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.56,
                                                                              0.7),
                                                                      child: Text(
                                                                          widget
                                                                              .model
                                                                              .carPosition,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                40,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                ('IBM Plex Sans Thai'),
                                                                          )),
                                                                    ),
                                                                       Align(                                                   
                                                                      alignment: AlignmentDirectional(-0.9, 1.7),
                                                                      child: Text(
                                                                        'ประวัติรถยนต์',
                                                                        style: TextStyle(
                                                                          fontSize: 16,
                                                                          fontFamily:('IBM Plex Sans Thai'),
                                                                          color:Color(0xffD4D4D4),
                                                                        )  
                                                                      ),
                                                                    ),
                                                                                                                        ])),
                                                        )))),
                                          ),
                                        ),
                                        const SizedBox(height: 300),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color(0xffE52628),
                                                  minimumSize:
                                                      const Size.fromHeight(40),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              onPressed: () {},
                                              child: const Text('เบิกรถยนต์',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        ('IBM Plex Sans Thai'),
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            )),
                                      ]),
                                    ),
                                  ),
                                )),

                            const SizedBox(height: 10),
                            // ignore: avoid_unnecessary_containers
                            Container(
                              child: const Text(
                                'Powered by Weise Technika',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromARGB(255, 228, 223, 223),
                                  fontFamily: ('IBM Plex Sans Thai'),
                                ),
                              ),
                            ),
                          ])),
                ),
              ),
            )
          ]),
        ));
  }
}
