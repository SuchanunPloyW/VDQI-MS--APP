// ignore_for_file: sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';

import '../FindcarPage/Model/FindcarModel.dart';

class MycarsdetailPage extends StatefulWidget {
  const MycarsdetailPage({Key? key, required this.model}) : super(key: key);
  final CarAPI model;
  @override
  State<MycarsdetailPage> createState() => _MycarsdetailPageState();
}

class _MycarsdetailPageState extends State<MycarsdetailPage> {
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
              text: const TextSpan(
                  text: "รายละเอียดรถยนต์",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: ('IBM Plex Sans Thai'),
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
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
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MycarsPage()));
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
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
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
                      children: const [],
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
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Color(0xffF6F6F6),
                                                  blurRadius: 20,
                                                  offset: Offset(5, 5),
                                                ),
                                              ],
                                            ),
                                            height: 85.0,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: ListTile(
                                                title: Text(
                                                  widget.model.carChassis,
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        ('IBM Plex Sans Thai'),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                leading: AspectRatio(
                                                  aspectRatio: 1,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                1.0)),
                                                    child: Image.asset(
                                                      'assets/images/car3.png',
                                                      height: 70.0,
                                                      width: 70,
                                                    ),
                                                  ),
                                                ),
                                                subtitle: const Text(
                                                  ' Yaris Ativ 1.2 G ',
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
                                            decoration: const BoxDecoration(
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Color(0xffF6F6F6),
                                                  blurRadius: 20,
                                                  offset: Offset(5, 5),
                                                ),
                                              ],
                                            ),
                                            height: 85.0,
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -0.99, -0.45),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Container(
                                                        height: 87,
                                                        width: 87,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 2,
                                                              color: Color(
                                                                  0x33000000),
                                                              offset:
                                                                  Offset(0, 2),
                                                            )
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 1),
                                                              child: IconButton(
                                                                icon: Image.asset('assets/images/iconscan.png'),
                                                                iconSize: 35,
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            ),
                                                            const Text(
                                                              "แสกน",
                                                              style: TextStyle(
                                                                  fontWeight:FontWeight.bold,
                                                                  fontSize: 14,
                                                                  color: Color(0xff929292)
                                                                  
                                                                      
                                                                          ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Container(
                                                      height: 87,
                                                      width: 230,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 2,
                                                            color: Color(
                                                                0x33000000),
                                                            offset:
                                                                Offset(0, 2),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        /* Stack(children: [
                                        /*    child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)), */
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: Container(
                                              child: Align(
                                                  alignment: AlignmentDirectional(-0.99, -0.45),
                                                
                                                child: Container(
                                                  height: 87,
                                                  width: 87,

                                                  decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 20,
                                                        color: Color(0x33000000),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]), */
                                        /* Padding(
                                          padding: const EdgeInsets.only( left: 10, right: 10),
                                             
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color:
                                                      const Color(0xffF6F6F6),
                                                  blurRadius: 20,
                                                  offset: const Offset(5, 5),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ), */
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
                                              child: const Text(
                                                  'เช็คอินเข้าสถานี',
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
  /*  void _request() async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: ("ต้องการทำรายการ ?"),
      desc: (' คุณต้องการทำรายการเบิกรถยนต์' + "\n" + widget.model.carChassis + " ใช่หรือไม่"),
      buttons: [
        DialogButton(
          child: Text(
            "ยืนยัน",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MycarsPage())),
          color: Color(0xff44A73B),
        ),
        DialogButton(
          child: Text(
            "ยกเลิก",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xffE52628),
        )
      ],
    ).show();
  } */
}
