// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_new
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vdqims/Page/FindcarPage/FindcarPage.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';
import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import 'package:vdqims/Style/TextStyle.dart';

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
                  style: TextStyleMenuName.bodyMenuThai,
                  children:  <TextSpan>[
                    TextSpan(
                      text: '\nCar Infomation',
                      style: TextStyleMenuName.bodyMenuEng
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
                height: 290,
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
              padding: const EdgeInsets.only(top: 5),
              child: SingleChildScrollView(
                child: Positioned(
                  top: 80,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //////////////// /* Card white */   ////////////////
                            SizedBox(
                                height: 650,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(children: <Widget>[
                                        //////////////// /* Card เลขตัวถัง */   ////////////////
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            decoration: new BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 231, 224, 224),
                                                  blurRadius:
                                                      7.0, // soften the shadow
                                                  spreadRadius:
                                                      0.0, //extend the shadow
                                                  offset: Offset(
                                                    5.0, // Move to right 10  horizontally
                                                    5.0, // Move to bottom 10 Vertically
                                                  ),
                                                )
                                              ],
                                            ),
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
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  1.0)),
                                                      child: CircleAvatar(
                                                        child: Image.asset(
                                                          'assets/images/car4.png',
                                                          height: 28.0,
                                                          width: 30,
                                                        ),
                                                        radius: 62.0,
                                                        backgroundColor:
                                                            Color(0xff89EB80),
                                                      )),
                                                ),
                                                subtitle: const Text(
                                                  'Yaris Ativ 1.2 G \n' +
                                                      'สถานะ :' +
                                                      ' ว่าง',
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
                                            decoration: new BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 231, 224, 224),
                                                  blurRadius:
                                                      7.0, // soften the shadow
                                                  spreadRadius:
                                                      0.0, //extend the shadow
                                                  offset: Offset(
                                                    5.0, // Move to right 10  horizontally
                                                    5.0, // Move to bottom 10 Vertically
                                                  ),
                                                )
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
                                                                            /* fontFamily: ('IBM Plex Sans Thai'), */
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
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -0.9,
                                                                              1.7),
                                                                      child: Text(
                                                                          'ประวัติรถยนต์',
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
                                                              alignment: AlignmentDirectional(-0.10, 4.8),
                                                              child: DataTable(
                                                                horizontalMargin: 0,
                                                                columnSpacing: 30,
                                                                columns: const <DataColumn>[
                                                                  DataColumn(
                                                                    label: Expanded(
                                                                      child: Text(
                                                                        '',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Expanded(
                                                                      child: Text(
                                                                        '',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Expanded(
                                                                      child: Text(
                                                                        '',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Expanded(
                                                                      child: Text(
                                                                        '',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                                rows: const <DataRow>[
                                                                  DataRow(
                                                                    cells: <DataCell>[
                                                                      DataCell(Text('26-8-2022', style: TextStyle(fontSize: 10))),
                                                                      DataCell(Text('นำเข้า', style: TextStyle(fontSize: 10))),
                                                                      DataCell(Text('Stock A', style: TextStyle(fontSize: 10))),
                                                                      DataCell(Text('Suchanun', style: TextStyle(fontSize: 10))),
                                                                    ],
                                                                  ),
                                                                ],
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
                                              onPressed: () =>
                                                  _request(context),
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
                            Text(
                              'Powered by Weise Technika',
                              style: TextStyleFoot.bodyfoot
                            ),
                          ])),
                ),
              ),
            )
          ]),
        ));
  }

  // < ------------------      Alert        ------------------>
  _request(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      
    );
    Alert(
      context: context,
      style: alertStyle,
      image: Image.asset('assets/images/iconalert.png'),
      content: Padding(
        padding: const EdgeInsets.only(top : 8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("ต้องการทำรายการ ?", style: TextStyleAlert.body18bold),
          SizedBox(height: 5),
          Text("คุณต้องการทำรายการเบิกรถยนต์",
              style: TextStyleAlert.body15normal),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.model.carChassis, style: TextStyleAlert.body15bold),
              SizedBox(width: 5),
              Text("ใช่หรือไม่", style: TextStyleAlert.body15normal)
            ],
          )
        ]),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "ยืนยัน",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: ('IBM Plex Sans Thai'),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MycarsPage()));
            });
          },
          color: Color(0xff44A73B),
        ),
        DialogButton(
          child: Text(
            "ยกเลิก",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: ('IBM Plex Sans Thai'),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xffE52628),
        )
      ],
    ).show();
  }
  // < ------------------      Alert        ------------------>
}
