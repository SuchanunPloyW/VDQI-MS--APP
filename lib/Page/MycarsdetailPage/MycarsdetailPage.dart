// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vdqims/Page/CheckinPage/CheckinPage.dart';
import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import 'package:vdqims/Style/TextStyle.dart';
import 'package:http/http.dart' as http;

import '../../Service/Model/HistoryModel.dart';
import '../../Service/Model/ReqDBModel.dart';

class MycarsdetailPage extends StatefulWidget {
  
  const MycarsdetailPage({Key? key, required this.model}) : super(key: key);
  final ReqDBAPI model;
  @override
  State<MycarsdetailPage> createState() => _MycarsdetailPageState();
}

class _MycarsdetailPageState extends State<MycarsdetailPage> {
  String qrCode = '';
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    dynamic carreq = widget.model.carid.car_chassis;
    Future<List<HistoryDBAPI>> getreq() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');

      // response uri
      var response = await http.get(
          Uri.parse('http://206.189.92.79/api/history/search/$carreq'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
          });
      // return value
      var req = HistoryDB.fromJson(jsonDecode(response.body));
      return req.data;
    }

    //<--------------------   QR  -------------------->
    String qrCode = '';
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
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //////////////// /* Card white */   ////////////////
                          SizedBox(
                              height: 600,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    child: Column(children: <Widget>[
                                      //////////////// /* Card เลขตัวถัง */   ////////////////
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 8, left: 8),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                  bottomLeft:
                                                      Radius.circular(12),
                                                  bottomRight:
                                                      Radius.circular(12)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.1),
                                                  blurRadius: 10,
                                                  /*   offset: Offset(0, 3), */
                                                ),
                                              ]),

                                          /* decoration: const BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Color(0xffF6F6F6),
                                            blurRadius: 20,
                                            offset: Offset(5, 5),
                                          ),
                                        ],
                                        ), */
                                          height: 75.0,
                                          child: ListTile(
                                            title: Text(
                                              widget.model.carid.car_chassis,
                                              style: TextStyleMycar.title,
                                              maxLines: 1,
                                              textScaleFactor: 1,
                                            ),
                                            leading: AspectRatio(
                                              aspectRatio: 1,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(1.0)),
                                                child: Image.asset(
                                                  'assets/images/car3.png',
                                                  height: 70.0,
                                                  width: 70,
                                                ),
                                              ),
                                            ),
                                            subtitle: AutoSizeText(
                                              'Yaris Ativ 1.2 G ',
                                              maxLines: 1,
                                              style: TextStyleMycar.subtitle,
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //////////////// /* Card เลขตัวถัง */   ////////////////

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 8, left: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 87,
                                              width: 87,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.white,
                                                         
                                                          onPrimary:
                                                              const Color.fromARGB(255,224,197,197),
                                                                  
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                          )),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                          'assets/images/iconscan.png'),
                                                      Text(
                                                        'สแกน',
                                                        style:
                                                            TextStyleMycar.scan,
                                                        textScaleFactor: 1,
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () => scanQRCode(),
                                                ),
                                                
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 87,
                                                width: double.infinity,
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(12),
                                                              bottomLeft: Radius
                                                                  .circular(12),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.1),
                                                          blurRadius: 10,
                                                          /*   offset: Offset(0, 3), */
                                                        ),
                                                      ]),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -0.05, 0.25),
                                                        child: Text(
                                                            widget
                                                                .model
                                                                .carid
                                                                .carWhere
                                                                .carWhere,
                                                            style:
                                                                TextStyleMycar
                                                                    .station,
                                                            textScaleFactor:
                                                                1.0),
                                                      ),
                                                      const Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -0.96, -0.95),
                                                          child: Text(
                                                            ' สถานที่',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xffD4D4D4),
                                                              fontFamily:
                                                                  ('Bai Jamjuree'),
                                                            ),
                                                            textScaleFactor: 1,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 8, right: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 87,
                                                width: double.infinity,
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(12),
                                                              bottomLeft: Radius
                                                                  .circular(12),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.1),
                                                          blurRadius: 10,
                                                          /*   offset: Offset(0, 3), */
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    children: <Widget>[
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1),
                                                        child: AutoSizeText(
                                                            'แถว',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xffD4D4D4),
                                                              fontFamily:
                                                                  ('Bai Jamjuree'),
                                                            ),
                                                            textScaleFactor:
                                                                1.0),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0),
                                                        child: AutoSizeText(
                                                            widget.model.carid
                                                                .car_line,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 36,
                                                              color: Color(
                                                                  0xff404040),
                                                              fontFamily:
                                                                  ('Kanit'),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            textScaleFactor:
                                                                1.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: SizedBox(
                                                  height: 87,
                                                  width: double.infinity,
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        12)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.1),
                                                            blurRadius: 10,
                                                            /*   offset: Offset(0, 3), */
                                                          ),
                                                        ]),
                                                    child: Column(
                                                      children: <Widget>[
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1),
                                                          child: Text('ลำดับ',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xffD4D4D4),
                                                                fontFamily:
                                                                    ('Bai Jamjuree'),
                                                              ),
                                                              textScaleFactor:
                                                                  1.0),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 1),
                                                          child: Text(
                                                              widget.model.carid
                                                                  .car_position,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 36,
                                                                color: Color(
                                                                    0xff404040),
                                                                fontFamily:
                                                                    ('Kanit'),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              textScaleFactor:
                                                                  1.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
                                                  fontFamily: ('Bai Jamjuree'),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xffD4D4D4)),
                                              textScaleFactor: 1,
                                            )),
                                      ),
                                      const SizedBox(height: 2),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 0),
                                        child: SingleChildScrollView(
                                          child:
                                              FutureBuilder<List<HistoryDBAPI>>(
                                                  future: getreq(),
                                                  builder: (context, snapShot) {
                                                    if (snapShot.hasData) {
                                                      return SingleChildScrollView(
                                                        child: Container(
                                                          height: 190,
                                                          width:
                                                              double.infinity,
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
                                                                child:
                                                                    DataTable(
                                                                  headingRowHeight:
                                                                      2,
                                                                  horizontalMargin:
                                                                      0,
                                                                  columnSpacing:
                                                                      0,
                                                                  columns: const <
                                                                      DataColumn>[
                                                                    DataColumn(
                                                                        label:
                                                                            Expanded(
                                                                      child:
                                                                          Text(
                                                                        '',
                                                                      ),
                                                                    )),
                                                                    DataColumn(
                                                                        label:
                                                                            Expanded(
                                                                      child:
                                                                          Text(
                                                                        '',
                                                                      ),
                                                                    )),
                                                                    DataColumn(
                                                                        label:
                                                                            Expanded(
                                                                      child:
                                                                          Text(
                                                                        '',
                                                                      ),
                                                                    )),
                                                                    DataColumn(
                                                                        label:
                                                                            Expanded(
                                                                      child:
                                                                          Text(
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
                                                                          '${e.date}',
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: ('Bai Jamjuree')),
                                                                          textScaleFactor:
                                                                              1,
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          '${e.carStatus.car_status}',
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: ('Bai Jamjuree')),
                                                                          textScaleFactor:
                                                                              1,
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          '${e.carWhere.carWhere}',
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: ('Bai Jamjuree')),
                                                                          textScaleFactor:
                                                                              1,
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          '${e.fullname}',
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: ('Bai Jamjuree')),
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
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: baseColor1,
                                                        ),
                                                      );
                                                    }
                                                  }),
                                        ),
                                      ),

                                      const SizedBox(height: 30),
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
                                                _CheckIn(model: widget.model),
                                            child: AutoSizeText(
                                              'เช็คอินเข้าสถานี',
                                              style: TextStyleBtn.bodybtn,
                                              maxFontSize: 12,
                                              minFontSize: 11,
                                            ),
                                          ))
                                    ]),
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

  void _CheckIn({required ReqDBAPI model}) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => CheckinPage(model: widget.model ,QR : qrCode)));
    });
  }
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
         Navigator.push(context,
          MaterialPageRoute(builder: (_) => CheckinPage(model: widget.model , QR : qrCode)));

      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
