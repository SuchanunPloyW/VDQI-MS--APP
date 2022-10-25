// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_new
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Page/FindcarPage/FindcarPage.dart';
import 'package:vdqims/Page/FindcarPage/Model/responsModel.dart';
import 'package:vdqims/SplashScreen/ReqSplash.dart';
import 'package:vdqims/Style/TextStyle.dart';
import '../../Service/API/PositionAPI.dart';
import '../../Service/API/PostReqApi.dart';
import '../../Service/Model/PositDBModel.dart';
import '../../Service/Model/ReqDBModel.dart';
import '../FindcarPage/Model/FindcarModel.dart';
import 'package:http/http.dart' as http;

class CardetailPage extends StatefulWidget {
  const CardetailPage({Key? key, required this.model}) : super(key: key);
  final CarAPI model;

  State<CardetailPage> createState() => _CardetailPageState();
}

class _CardetailPageState extends State<CardetailPage> {
  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
  }

  bool _isLoading = false;
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  String? selected = "";
  String? line = "";
  String? sort = "";

  @override
  Widget build(BuildContext context) {
    dynamic carreq = widget.model.carId;
    Future<List<ReqDBAPI>> getreq() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');

      // response uri
      var response = await http.get(
          Uri.parse('http://206.189.92.79/api/reqDB/search/$carreq'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
          });
      // return value
      var req = ReqDB.fromJson(jsonDecode(response.body));
      return req.data;
    }

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
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //////////////// /* Card white */   ////////////////
                          SizedBox(
                              height: 650,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(children: <Widget>[
                                      //////////////// /* Card เลขตัวถัง */   ////////////////
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.1),
                                                    blurRadius: 12,
                                                    /*   offset: Offset(0, 3), */
                                                  ),
                                                ]),
                                          height: 85,
                                          child: ListTile(
                                            title: Text(
                                              widget.model.carChassis,
                                              style: const TextStyle(
                                                color: Color(0xff404040),
                                                fontFamily:
                                                    ('IBM Plex Sans Thai'),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              textScaleFactor: 1,
                                            ),
                                            leading: AspectRatio(
                                              aspectRatio: 1,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              1.0)),
                                                  child: CircleAvatar(
                                                    child: Image.asset(
                                                      'assets/images/car4.png',
                                                      height: 28.0,
                                                      width: 30,
                                                    ),
                                                    radius: 62.0,
                                                    backgroundColor: (widget
                                                                .model
                                                                .carStatus
                                                                .statusId ==
                                                            1
                                                        ? const Color(
                                                            0xff89EB80)
                                                        : const Color(
                                                            0xffEB8080)),
                                                  )),
                                            ),
                                            subtitle: Text(
                                              'Yaris Ativ 1.2 G \n' +
                                                  'สถานะ :' +
                                                  ' ' +
                                                  widget.model.carStatus
                                                      .carStatus,
                                              style: TextStyle(
                                                color: Color(0xff404040),
                                                fontFamily: ('Bai Jamjuree'),
                                                fontWeight: FontWeight.w300,
                                              ),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: SizedBox(
                                          height: 160,
                                          width: double.infinity,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.1),
                                                    blurRadius: 12,
                                                    /*   offset: Offset(0, 3), */
                                                  ),
                                                ]),
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
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Container(
                                                          height: 160,
                                                          child:
                                                              Stack(children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -0.9,
                                                                      -0.9),
                                                              child: Text(
                                                                'สถานที่',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xffD4D4D4),
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      ('Bai Jamjuree'),
                                                                ),
                                                                textScaleFactor:
                                                                    1,
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -0.05,
                                                                      -0.59),
                                                              child: Text(
                                                                  widget
                                                                      .model
                                                                      .carWhere
                                                                      .carWhere,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff404040),
                                                                    fontSize:
                                                                        36,
                                                                    fontFamily:
                                                                        ('Kanit'),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1.0),
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
                                                                  color: Color(
                                                                      0xffD4D4D4),
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      ('Bai Jamjuree'),
                                                                ),
                                                                textScaleFactor:
                                                                    1,
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -0.56,
                                                                      0.7),
                                                              child: Text(
                                                                widget.model
                                                                    .carLine,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xff404040),
                                                                  fontSize: 36,
                                                                  fontFamily:
                                                                      ('Kanit'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                ),
                                                                textScaleFactor:
                                                                    1,
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.1, 0.1),
                                                              child: Text(
                                                                'ลำดับ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      ('Bai Jamjuree'),
                                                                  color: Color(
                                                                      0xffD4D4D4),
                                                                ),
                                                                textScaleFactor:
                                                                    1,
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.56,
                                                                      0.7),
                                                              child: Text(
                                                                widget.model
                                                                    .carPosition,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 40,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontFamily:
                                                                      ('Kanit'),
                                                                ),
                                                                textScaleFactor:
                                                                    1,
                                                              ),
                                                            ),
                                                          ])),
                                                    ))),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              ' ประวัติรถยนต์',
                                              style: TextStyle(
                                                fontFamily: ('Kanit'),
                                                fontSize: 18,
                                                color: Color(0xffD4D4D4),
                                              ),
                                              textScaleFactor: 1,
                                            )),
                                      ),
                                      const SizedBox(height: 2),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 0),
                                        child: SingleChildScrollView(
                                          child: FutureBuilder<List<ReqDBAPI>>(
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
                                                          child:
                                                              SingleChildScrollView(
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
                                                                    DataCell(
                                                                        Text(
                                                                      '${e.req_date}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              ('Bai Jamjuree')),
                                                                      textScaleFactor:
                                                                          1,
                                                                    )),
                                                                    DataCell(
                                                                        Text(
                                                                      '${e.carid.carStatus.car_status}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              ('Bai Jamjuree')),
                                                                      textScaleFactor:
                                                                          1,
                                                                    )),
                                                                    DataCell(
                                                                        Text(
                                                                      '${e.carid.carWhere.carWhere}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              ('Bai Jamjuree')),
                                                                      textScaleFactor:
                                                                          1,
                                                                    )),
                                                                    DataCell(
                                                                        Text(
                                                                      '${e.req_fullname}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              ('Bai Jamjuree')),
                                                                      textScaleFactor:
                                                                          1,
                                                                    )),
                                                                  ],
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container(
                                                    height: 190,
                                                  );
                                                }
                                              }),
                                        ),
                                      ),

                                      const SizedBox(height: 40),
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
                                            onPressed: () => _request(context),
                                            child: AutoSizeText(
                                              'เบิกรถยนต์',
                                              style: TextStyleBtn.bodybtn,
                                              maxFontSize: 12,
                                              minFontSize: 11,
                                            ),
                                          )),
                                      const SizedBox(height: 5),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.cyan[900],
                                                minimumSize:
                                                    const Size.fromHeight(40),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            onPressed: () {
                                              if (widget
                                                      .model.carWhere.whereId ==
                                                  1) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _DialogStockA(context),
                                                );
                                              } else if (widget
                                                      .model.carWhere.whereId ==
                                                  2) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _DialogStockB(context),
                                                );
                                              } else if (widget
                                                      .model.carWhere.whereId ==
                                                  3) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _DialogStockC(context),
                                                );
                                              } else if (widget
                                                      .model.carWhere.whereId ==
                                                  4) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _DialogStockD(context),
                                                );
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: new Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  Lottie.asset(
                                                                      'assets/images/map.json',
                                                                      height:
                                                                          150,
                                                                      width:
                                                                          150),
                                                                  Center(
                                                                      child: Text(
                                                                          'รถกำลังดำเนินการที่',
                                                                          style:
                                                                              TextStyleAlert.body16bold)),
                                                                  Center(
                                                                      child: Text(
                                                                          widget
                                                                              .model
                                                                              .carWhere
                                                                              .carWhere,
                                                                          style:
                                                                              TextStyleAlert.body18bold)),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          new ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                primary:
                                                                    const Color(
                                                                        0xffE52628),
                                                                minimumSize:
                                                                    const Size
                                                                            .fromHeight(
                                                                        40),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10))),
                                                            child: const Text(
                                                                'ตกลง'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              }
                                            },
                                            child: AutoSizeText(
                                              'แผนผังแสดงลานจอด',
                                              style: TextStyleBtn.bodybtn,
                                              maxFontSize: 12,
                                              minFontSize: 11,
                                            ),
                                          )),
                                    ]),
                                  ),
                                ),
                              )),

                          const SizedBox(height: 10),
                          Text('Powered by Weise Technika',
                              style: TextStyleFoot.bodyfoot,
                              textScaleFactor: 1.0),
                        ])),
              ),
            )
          ]),
        ));
  }

// <------------------------- Dialog Stock  -------------------------->
  Widget _DialogStockA(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text('แผนผังแสดงลานจอด Stock A',
                        style: TextStyleAlert.body16bold)),
                Center(
                  child: _buildStockA(),
                )
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              primary: const Color(0xffE52628),
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text('ตกลง'),
        ),
      ],
    );
  }

  Widget _DialogStockB(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text('แผนผังแสดงลานจอด Stock B',
                        style: TextStyleAlert.body16bold)),
                Center(
                  child: _buildStockB(),
                )
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              primary: const Color(0xffE52628),
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text('ตกลง'),
        ),
      ],
    );
  }

  Widget _DialogStockC(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text('แผนผังแสดงลานจอด Stock C',
                        style: TextStyleAlert.body16bold)),
                Center(
                  child: _buildStockC(),
                )
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              primary: const Color(0xffE52628),
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text('ตกลง'),
        ),
      ],
    );
  }

  Widget _DialogStockD(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text('แผนผังแสดงลานจอด Stock D',
                        style: TextStyleAlert.body16bold)),
                Center(
                  child: _buildStockD(),
                )
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              primary: const Color(0xffE52628),
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text('ตกลง'),
        ),
      ],
    );
  }
// <------------------------- Stock  -------------------------->

  Widget _buildStockA() {
    return Container(
      height: 400,
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xffE2E8F0))),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
        ),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("A",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("B",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("C",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              textScaleFactor: 1,
                              "D",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(children: [
                              Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                    color: const Color.fromARGB(
                                        246, 231, 230, 236),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '',
                                      textScaleFactor: 1,
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              height: 350,
                              child: FutureBuilder(
                                  future: PostionService().getWhere1(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<PositDBAPI>?>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      List<PositDBAPI>? data = snapshot.data;
                                      return Container(
                                          width: 20,
                                          height: 20,
                                          child: GridView.builder(
                                              padding: const EdgeInsets.all(10),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: 4,
                                              ),
                                              itemCount: data!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: (data[index]
                                                                    .carid
                                                                    .car_id ==
                                                                widget.model
                                                                    .carId &&
                                                            data[index]
                                                                    .car_status ==
                                                                1
                                                        ? Colors.blue
                                                        : data[index]
                                                                    .car_status ==
                                                                1
                                                            ? Colors.red
                                                            : data[index]
                                                                        .car_status ==
                                                                    2
                                                                ? Colors.grey
                                                                : const Color(
                                                                    0xff89EB80)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return new AlertDialog(
                                                              content:
                                                                  new Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                    children: [
                                                                      Lottie.asset(
                                                                          'assets/images/map.json',
                                                                          height:
                                                                              150,
                                                                          width:
                                                                              150),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              "เลขตัวถัง : ${data[index].carid.car_chassis}",
                                                                              textScaleFactor: 1,
                                                                              style: TextStyleAlert.body16bold),
                                                                          Text(
                                                                              "รุ่น : Yaris Ativ 1.2 G ",
                                                                              textScaleFactor: 1,
                                                                              style: TextStyleAlert.body16bold),
                                                                          Text(
                                                                              "สี : แดง ",
                                                                              textScaleFactor: 1,
                                                                              style: TextStyleAlert.body16bold),
                                                                          Row(
                                                                            children: [
                                                                              Text("ตำแหน่ง :  ${data[index].line}", textScaleFactor: 1, style: TextStyleAlert.body16bold),
                                                                              Text("${data[index].posit}  ", textScaleFactor: 1, style: TextStyleAlert.body16bold),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ))
                                                                ],
                                                              ),
                                                              actions: <Widget>[
                                                                new ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary:
                                                                          const Color(
                                                                              0xffE52628),
                                                                      minimumSize:
                                                                          const Size.fromHeight(
                                                                              40),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10))),
                                                                  child:
                                                                      const Text(
                                                                          'ตกลง'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        textScaleFactor: 1,
                                                        data[index]
                                                            .posit
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }));
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    );
                                  })),
                        )
                      ],
                    )),
              )
            ],
          ),
        ))
      ]),
    );
  }

  Widget _buildStockB() {
    return Container(
      height: 400,
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xffE2E8F0))),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
        ),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("A",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("B",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("C",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              textScaleFactor: 1,
                              "D",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              textScaleFactor: 1,
                              "E",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(children: [
                              Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                    color: const Color.fromARGB(
                                        246, 231, 230, 236),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '',
                                      textScaleFactor: 1,
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              height: 350,
                              child: FutureBuilder(
                                  future: PostionService().getWhere2(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<PositDBAPI>?>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      List<PositDBAPI>? data = snapshot.data;
                                      return Container(
                                          width: 20,
                                          height: 20,
                                          child: GridView.builder(
                                              padding: const EdgeInsets.all(10),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: 5,
                                              ),
                                              itemCount: data!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: (data[index]
                                                                    .carid
                                                                    .car_id ==
                                                                widget.model
                                                                    .carId &&
                                                            data[index]
                                                                    .car_status ==
                                                                1
                                                        ? Colors.blue
                                                        : data[index]
                                                                    .car_status ==
                                                                1
                                                            ? Colors.red
                                                            : data[index]
                                                                        .car_status ==
                                                                    2
                                                                ? Colors.grey
                                                                : const Color(
                                                                    0xff89EB80)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return new AlertDialog(
                                                              content:
                                                                  new Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Lottie.asset(
                                                                            'assets/images/map.json',
                                                                            height:
                                                                                150,
                                                                            width:
                                                                                150),
                                                                        Text(
                                                                          'Chassis No',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                ('Kanit'),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          data[index]
                                                                              .carid
                                                                              .car_chassis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                ('Kanit'),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              actions: <Widget>[
                                                                new ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary:
                                                                          const Color(
                                                                              0xffE52628),
                                                                      minimumSize:
                                                                          const Size.fromHeight(
                                                                              40),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10))),
                                                                  child:
                                                                      const Text(
                                                                          'ตกลง'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        textScaleFactor: 1,
                                                        data[index]
                                                            .posit
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }));
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    );
                                  })),
                        )
                      ],
                    )),
              )
            ],
          ),
        ))
      ]),
    );
  }

  Widget _buildStockC() {
    return Container(
      height: 400,
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xffE2E8F0))),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
        ),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("A",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("B",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("C",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              textScaleFactor: 1,
                              "D",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              textScaleFactor: 1,
                              "E",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(children: [
                              Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                    color: const Color.fromARGB(
                                        246, 231, 230, 236),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '',
                                      textScaleFactor: 1,
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              height: 350,
                              child: FutureBuilder(
                                  future: PostionService().getWhere3(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<PositDBAPI>?>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      List<PositDBAPI>? data = snapshot.data;
                                      return Container(
                                          width: 20,
                                          height: 20,
                                          child: GridView.builder(
                                              padding: const EdgeInsets.all(10),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: 5,
                                              ),
                                              itemCount: data!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: (data[index]
                                                                    .carid
                                                                    .car_id ==
                                                                widget.model
                                                                    .carId &&
                                                            data[index]
                                                                    .car_status ==
                                                                1
                                                        ? Colors.blue
                                                        : data[index]
                                                                    .car_status ==
                                                                1
                                                            ? Colors.red
                                                            : data[index]
                                                                        .car_status ==
                                                                    2
                                                                ? Colors.grey
                                                                : const Color(
                                                                    0xff89EB80)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return new AlertDialog(
                                                              content:
                                                                  new Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Lottie.asset(
                                                                            'assets/images/map.json',
                                                                            height:
                                                                                150,
                                                                            width:
                                                                                150),
                                                                        Text(
                                                                          'Chassis No',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                ('Kanit'),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          data[index]
                                                                              .carid
                                                                              .car_chassis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                ('Kanit'),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              actions: <Widget>[
                                                                new ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary:
                                                                          const Color(
                                                                              0xffE52628),
                                                                      minimumSize:
                                                                          const Size.fromHeight(
                                                                              40),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10))),
                                                                  child:
                                                                      const Text(
                                                                          'ตกลง'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        textScaleFactor: 1,
                                                        data[index]
                                                            .posit
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }));
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    );
                                  })),
                        )
                      ],
                    )),
              )
            ],
          ),
        ))
      ]),
    );
  }

  Widget _buildStockD() {
    return Container(
      height: 400,
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xffE2E8F0))),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
        ),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("A",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("B",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("C",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              textScaleFactor: 1,
                              "D",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              textScaleFactor: 1,
                              "E",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(children: [
                              Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                    color: const Color.fromARGB(
                                        246, 231, 230, 236),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '',
                                      textScaleFactor: 1,
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              height: 350,
                              child: FutureBuilder(
                                  future: PostionService().getWhere4(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<PositDBAPI>?>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      List<PositDBAPI>? data = snapshot.data;
                                      return Container(
                                          width: 20,
                                          height: 20,
                                          child: GridView.builder(
                                              padding: const EdgeInsets.all(10),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: 5,
                                              ),
                                              itemCount: data!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: (data[index]
                                                                    .carid
                                                                    .car_id ==
                                                                widget.model
                                                                    .carId &&
                                                            data[index]
                                                                    .car_status ==
                                                                1
                                                        ? Colors.blue
                                                        : data[index]
                                                                    .car_status ==
                                                                1
                                                            ? Colors.red
                                                            : data[index]
                                                                        .car_status ==
                                                                    2
                                                                ? Colors.grey
                                                                : const Color(
                                                                    0xff89EB80)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return new AlertDialog(
                                                              content:
                                                                  new Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Lottie.asset(
                                                                            'assets/images/map.json',
                                                                            height:
                                                                                150,
                                                                            width:
                                                                                150),
                                                                        Text(
                                                                          'Chassis No',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                ('Kanit'),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          data[index]
                                                                              .carid
                                                                              .car_chassis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontFamily:
                                                                                ('Kanit'),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              actions: <Widget>[
                                                                new ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary:
                                                                          const Color(
                                                                              0xffE52628),
                                                                      minimumSize:
                                                                          const Size.fromHeight(
                                                                              40),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10))),
                                                                  child:
                                                                      const Text(
                                                                          'ตกลง'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        textScaleFactor: 1,
                                                        data[index]
                                                            .posit
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }));
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    );
                                  })),
                        )
                      ],
                    )),
              )
            ],
          ),
        ))
      ]),
    );
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
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "ต้องการทำรายการ ?",
            style: TextStyleAlert.body18bold,
            textScaleFactor: 1,
          ),
          SizedBox(height: 5),
          Text(
            "คุณต้องการทำรายการเบิกรถยนต์",
            style: TextStyleAlert.body15normal,
            textScaleFactor: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.model.carChassis,
                style: TextStyleAlert.body15bold,
                textScaleFactor: 1,
              ),
              SizedBox(width: 5),
              Text(
                "ใช่หรือไม่",
                style: TextStyleAlert.body15normal,
                textScaleFactor: 1,
              )
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
          onPressed: () async {
            ResponseModel response = await ReqAPIDB().PostReq(
              widget.model.carId,
              DateFormat("yyyy-MM-dd").format(DateTime.now()),
              DateFormat("hh:mm:ss a").format(DateTime.now()),
              "${userData['fullname']}",
              "${userData['lastname']}",
            );

            /*   ResponseModel response = await PostReqAPI().PostReq(
                widget.model.carChassis,
                "${userData['fullname']}",
                "${userData['lastname']}",
                DateFormat("yyyy-MM-dd").format(DateTime.now()),
                DateFormat("hh:mm:ss a").format(DateTime.now()),
                widget.model.carPosition,
                widget.model.carWhere.carWhere,
                "2",
                "2",
                widget.model.carLine); */

            if (response.success) {
              ResponseModel respones1 = await PutCar(
                  "2",
                  widget.model.carPosition,
                  widget.model.carWhere.whereId.toString(),
                  widget.model.carLine);
              if (respones1.success) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Reqsplash()));
              }
            } else {
              print("ไม่สำเร็จ");
            }
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

  // <------------------------ updateposition ------------------------>
  dynamic urlup = 'http://206.189.92.79/api/';
  Future<ResponseModel> PutCar(
    dynamic car_status,
    dynamic car_position,
    dynamic car_where,
    dynamic car_line,
  ) async {
    try {
      Map<String, String> data = {
        'car_status': car_status,
        'car_position': car_position,
        'car_where': car_where,
        'car_line': car_line,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      var ID = localStorage.getString('ID');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
      };
      if (_authToken != null) {
        urlup = Uri.parse("http://206.189.92.79/api/car/$ID");
        await http.put(
          urlup,
          body: dataencode,
          headers: headers,
        );
      }
      return ResponseModel(success: true);
    } catch (e) {
      return ResponseModel(success: false, message: e.toString());
    }
  }
}
