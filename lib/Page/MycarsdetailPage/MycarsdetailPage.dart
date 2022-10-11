// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vdqims/Page/CheckinPage/CheckinPage.dart';
import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import 'package:vdqims/Service/Model/ReqModel.dart';
import 'package:vdqims/Style/TextStyle.dart';
import 'package:http/http.dart' as http;

class MycarsdetailPage extends StatefulWidget {
  const MycarsdetailPage({Key? key, required this.model}) : super(key: key);
  final ReqAPI model;
  @override
  State<MycarsdetailPage> createState() => _MycarsdetailPageState();
}

class _MycarsdetailPageState extends State<MycarsdetailPage> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    dynamic carreq = widget.model.carChassis;
    Future<List<ReqAPI>> getreq() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');

      // response uri
      var response = await http
          .get(Uri.parse('http://206.189.92.79/api/req/search/$carreq'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
      });
      // return value
      var req = Req.fromJson(jsonDecode(response.body));
      return req.data;
    }
    // --------------------------------- Scaffold -------------------------------------------------
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "รายละเอียดรถยนต์",
                  style: TextStyleMenuName.bodyMenuThai,
                  children: <TextSpan>[
                    TextSpan(
                        text: '\nCar Infomation',
                        style: TextStyleMenuName.bodyMenuEng),
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
            //////////////// /* BG RED */   ////////////////
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
            //////////////// /* BG RED */   ////////////////

            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //////////////// /* Card white */   ////////////////
                          SizedBox(
                              height: 650,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SingleChildScrollView(
                                      child: Column(children: <Widget>[
                                        //////////////// /* Card เลขตัวถัง */   ////////////////
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            /* decoration: const BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Color(0xffF6F6F6),
                                              blurRadius: 20,
                                              offset: Offset(5, 5),
                                            ),
                                          ],
                                        ), */
                                            height: 85.0,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: ListTile(
                                                title: Text(
                                                    widget.model.carChassis,
                                                    style:
                                                        TextStyleMycar.title),
                                                leading: AspectRatio(
                                                  aspectRatio: 1,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                1.0)),
                                                    child: Image.asset(
                                                      'assets/images/car3.png',
                                                      height: 70.0,
                                                      width: 70,
                                                    ),
                                                  ),
                                                ),
                                                subtitle: Text(
                                                    'Yaris Ativ 1.2 G ',
                                                    style: TextStyleMycar
                                                        .subtitle),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //////////////// /* Card เลขตัวถัง */   ////////////////

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                              /*  decoration: const BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Color(0xffF6F6F6),
                                                blurRadius: 20,
                                                offset: Offset(5, 5),
                                              ),
                                            ],
                                          ), */
                                              height: 87.0,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 87,
                                                    width: 87,
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 1),
                                                            child: IconButton(
                                                              icon: Image.asset(
                                                                  'assets/images/iconscan.png'),
                                                              iconSize: 35,
                                                              onPressed: () {},
                                                            ),
                                                          ),
                                                          Text("แสกน",
                                                              style:
                                                                  TextStyleMycar
                                                                      .scan),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 87,
                                                      width: double.infinity,
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        -0.05,
                                                                        0.25),
                                                                child: Text(
                                                                    widget
                                                                        .model
                                                                        .carWhere
                                                                        .carWhere,
                                                                    style: TextStyleMycar
                                                                        .station)),
                                                            const Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -0.98,
                                                                        -0.97),
                                                                child: Text(
                                                                  ' สถานที่',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Color(
                                                                        0xffD4D4D4),
                                                                    fontFamily:
                                                                        ('Bai Jamjuree'),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          /* /////////////  แถว ลำดับ  /////////////// */
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
                                            height: 87.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 87,
                                                    width: double.infinity,
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Column(
                                                        children:  <
                                                            Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 1),
                                                            child: Text(
                                                              'แถว',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xffD4D4D4),
                                                                fontFamily:
                                                                    ('Bai Jamjuree'),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 1),
                                                            child: Text(
                                                              widget.model.carLine,
                                                              style: TextStyle(
                                                                fontSize: 25,
                                                                color: Color(
                                                                    0xff404040),
                                                                fontFamily:
                                                                    ('Kanit'),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 87,
                                                    width: double.infinity,
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Column(
                                                        children: <Widget>[
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 1),
                                                            child: Text(
                                                              'ลำดับ',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xffD4D4D4),
                                                                fontFamily:
                                                                    ('Bai Jamjuree'),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 1),
                                                            child: Text(
                                                              widget.model
                                                                  .carPosition,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 25,
                                                                color: Color(
                                                                    0xff404040),
                                                                fontFamily:
                                                                    ('Kanit'),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 0),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                ' ประวัติรถยนต์',
                                                style: TextStyle(
                                                    fontFamily:
                                                        ('Bai Jamjuree'),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Color(0xffD4D4D4)),
                                              )),
                                        ),
                                        const SizedBox(height: 2),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 0),
                                          child: SingleChildScrollView(
                                            child: FutureBuilder<List<ReqAPI>>(
                                                future: getreq(),
                                                builder: (context, snapShot) {
                                                  if (snapShot.hasData) {
                                                    return SingleChildScrollView(
                                                      child: Container(
                                                        height: 190,
                                                        width: double.infinity,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 0),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 0),
                                                            child: DataTable(
                                                              headingRowHeight:
                                                                  2,
                                                              horizontalMargin:
                                                                  0,
                                                              columnSpacing: 0,
                                                              columns: const <
                                                                  DataColumn>[
                                                                DataColumn(
                                                                    label:
                                                                        Expanded(
                                                                  child: Text(
                                                                    '',
                                                                  ),
                                                                )),
                                                                DataColumn(
                                                                    label:
                                                                        Expanded(
                                                                  child: Text(
                                                                    '',
                                                                  ),
                                                                )),
                                                                DataColumn(
                                                                    label:
                                                                        Expanded(
                                                                  child: Text(
                                                                    '',
                                                                  ),
                                                                )),
                                                                DataColumn(
                                                                    label:
                                                                        Expanded(
                                                                  child: Text(
                                                                    '',
                                                                  ),
                                                                )),
                                                              ],
                                                              rows: snapShot
                                                                  .data!
                                                                  .map<DataRow>(
                                                                      (e) {
                                                                return DataRow(
                                                                  cells: <
                                                                      DataCell>[
                                                                    DataCell(Text(
                                                                        '${e.reqDate}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontFamily:
                                                                                ('Bai Jamjuree')))),
                                                                    DataCell(Text(
                                                                        '${e.carStatus.carStatus}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontFamily:
                                                                                ('Bai Jamjuree')))),
                                                                    DataCell(Text(
                                                                        '${e.carWhere.carWhere}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontFamily:
                                                                                ('Bai Jamjuree')))),
                                                                    DataCell(Text(
                                                                        '${e.fullname}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontFamily:
                                                                                ('Bai Jamjuree')))),
                                                                  ],
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: baseColor1,
                                                      ),
                                                    );
                                                  }
                                                }
                                                ),
                                          ),
                                        ),

                                        const SizedBox(height: 65),
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
                                              onPressed: () {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 1000),
                                                    () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CheckinPage(
                                                                model: widget
                                                                    .model
                                                                    .carChassis,
                                                              )));
                                                });
                                              },
                                              child: Text('เช็คอินเข้าสถานี',
                                                  style: TextStyleBtn.bodybtn),
                                            ))
                                      ]),
                                    ),
                                  ),
                                ),
                              )),

                          const SizedBox(height: 10),
                          Text('Powered by Weise Technika',
                              style: TextStyleFoot.bodyfoot),
                        ])),
              ),
            )
          ]),
        ));
  }
}
