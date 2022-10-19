// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_new
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Page/FindcarPage/FindcarPage.dart';
import 'package:vdqims/Page/FindcarPage/Model/responsModel.dart';
import 'package:vdqims/SplashScreen/ReqSplash.dart';
import 'package:vdqims/Style/TextStyle.dart';
import '../../Service/API/PostReqApi.dart';
import '../../Service/Model/ReqDBModel.dart';
import '../../Service/Model/ReqModel.dart';
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
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Container(
                                  decoration:  const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12)
                                  ),
                                   boxShadow: [
                                    BoxShadow(
                                       color: Color.fromRGBO(0, 0, 0, 0.05),
                                       blurRadius: 12,
                                      /*   offset: Offset(0, 3), */
                                      
                                    ),
                                   ]
                                  
                            ),
                                  
                                  
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(children: <Widget>[
                                      //////////////// /* Card เลขตัวถัง */   ////////////////
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          height: 85,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                                                                  .carStatus ==
                                                              "นำเข้า"
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          /* decoration: new BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 231, 224, 224),
                                            blurRadius: 7.0, // soften the shadow
                                            spreadRadius: 0.0, //extend the shadow
                                            offset: Offset(
                                              5.0, // Move to right 10  horizontally
                                              5.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                      ), */
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                                        fontSize:
                                                                            16,
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
                                                                          color:
                                                                              Color(0xff404040),
                                                                          fontSize:
                                                                              36,
                                                                          fontFamily:
                                                                              ('Kanit'),
                                                                          fontWeight:
                                                                              FontWeight.w900,
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
                                                                        fontSize:
                                                                            16,
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
                                                                      widget
                                                                          .model
                                                                          .carLine,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff404040),
                                                                        fontSize:
                                                                            36,
                                                                        fontFamily:
                                                                            ('Kanit'),
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1,
                                                                    ),
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
                                                                      widget
                                                                          .model
                                                                          .carPosition,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            40,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        fontFamily:
                                                                            ('Kanit'),
                                                                      ),
                                                                      textScaleFactor:
                                                                          1,
                                                                    ),
                                                                  ),
                                                                ])),
                                                      )))),
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
                                            onPressed: () => _request(context),
                                            child: AutoSizeText(
                                              'เบิกรถยนต์',
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
              "${userData['lastname']}",);
             
             
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
                  ResponseModel respones1 = await PutCar("2", widget.model.carPosition ,widget.model.carWhere.whereId.toString(),  widget.model.carLine );
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
