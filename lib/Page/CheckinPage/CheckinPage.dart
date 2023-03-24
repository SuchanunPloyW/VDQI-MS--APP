import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import 'package:http/http.dart' as http;
import 'package:vdqims/SplashScreen/CheckinSplash.dart';

import '../../Service/API/PostReqApi.dart';
import '../../Service/Model/ReqDBModel.dart';

import '../../Style/TextStyle.dart';
import '../../Service/Model/responsModel.dart';

class CheckinPage extends StatefulWidget {
  final dynamic QR;
  final ReqDBAPI model;

  const CheckinPage({
    Key? key,
    required this.model,
    required this.QR,
  }) : super(key: key);

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
/*   String qrCode = ''; */
  // <------------------------ updatereq ------------------------>
  dynamic urlup = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> Putreq(
    dynamic car_where,
    dynamic car_status,
  ) async {
    try {
      Map<String, String> data = {
        'car_status': car_status,
        'car_where': car_where,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      var carID = localStorage.getString('carID');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
      };
      if (_authToken != null) {
        urlup = Uri.parse("https://vdqi-db.toyotaparagon.com/api/cardb/$carID");
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

  dynamic urlup1 = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> PutPosit(
    dynamic car_status,
    dynamic car_id,
  ) async {
    try {
      Map<String, String> data = {
        'car_status': car_status,
        'car_id': car_id,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      var carID = widget.model.carid.positId.positId;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
      };
      if (_authToken != null) {
        urlup1 =
            Uri.parse("https://vdqi-db.toyotaparagon.com/api/posit/$carID");
        await http.put(
          urlup1,
          body: dataencode,
          headers: headers,
        );
      }
      return ResponseModel(success: true);
    } catch (e) {
      return ResponseModel(success: false, message: e.toString());
    }
  }

  // <------------------------ updateperson------------------------>
  dynamic urlup2 = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> Putperson(
    dynamic person,
  ) async {
    try {
      Map<String, String> data = {
        'person': person,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      var reqID = widget.model.req_id;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
      };
      if (_authToken != null) {
        urlup2 =
            Uri.parse("https://vdqi-db.toyotaparagon.com/api/reqDB/$reqID");
        await http.put(
          urlup2,
          body: dataencode,
          headers: headers,
        );
      }
      return ResponseModel(success: true);
    } catch (e) {
      return ResponseModel(success: false, message: e.toString());
    }
  }

  //<--------------------   get Dropdown Station -------------------->
  List? station_data;
  String? Staid;
  String? itesmvalue;
  var userData;

  var url = Uri.encodeFull('https://vdqi-db.toyotaparagon.com/api/where/s/1');
  Future<String> station() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');
    var res = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $_authToken',
    });
    var resBody = json.decode(res.body);
    //print(resBody);
    setState(() {
      station_data = resBody;
    });
    return "success";
  }

  //<--------------------   Color Bar -------------------->
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);

  //<--------------------   Controller -------------------->
  TextEditingController StationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.station();
    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        //<--------------------   App Bar  -------------------->
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "เช็คอินเข้าสถานี",
                  style: TextStyleMenuName.bodyMenuThai,
                  children: <TextSpan>[
                    TextSpan(
                        text: '\nCheck in',
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
          //<--------------------   Container BG Red -------------------->
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

          //<--------------------   Container Card white -------------------->
          Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height: 550,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.05),
                                                  blurRadius: 12,
                                                  spreadRadius: 5
                                                  /*   offset: Offset(0, 3), */
                                                  ),
                                            ]),
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: SingleChildScrollView(
                                              child: Column(children: <Widget>[
                                                //<--------------------   Container Card Chassis -------------------->
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Container(
                                                    height: 85,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.1),
                                                              blurRadius: 10,
                                                              spreadRadius: 2),
                                                        ]),
                                                    child: ListTile(
                                                      title: Text(
                                                        widget.model.carid
                                                            .car_chassis,
                                                        style: TextStyleinfor
                                                            .bodyinfor18,
                                                        textScaleFactor: 1,
                                                      ),
                                                      leading: AspectRatio(
                                                        aspectRatio: 1,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          1.0)),
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
                                                        style: TextStyleMycar
                                                            .subtitle,
                                                        textScaleFactor: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //<--------------------   CheckIn -------------------->
                                                const SizedBox(height: 20),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'ข้อมูลการเช็คอิน',
                                                        style: TextStyleCheckin
                                                            .bodyCheckin20,
                                                        textScaleFactor: 1,
                                                      )),
                                                ),
                                                //<--------------------   Station -------------------->
                                                const SizedBox(height: 8),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'สถานี',
                                                        style: TextStyleCheckin
                                                            .bodyCheckin16,
                                                        textScaleFactor: 1,
                                                      )),
                                                ),
                                                //<--------------------   DropDown -------------------->
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15),
                                                    child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: const Color(
                                                                      0xffE2E8F0),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.5)),
                                                        child: Container(
                                                          height: 35.2,
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              child:
                                                                  DropdownButton(
                                                                hint: Text(
                                                                  'กรุณาเลือกสถานี',
                                                                  style: TextStyleCheckin
                                                                      .bodyCheckin16,
                                                                  textScaleFactor:
                                                                      1,
                                                                ),
                                                                elevation: 10,
                                                                icon: const Icon(
                                                                    Icons
                                                                        .arrow_drop_down),
                                                                iconSize: 13.0,
                                                                isExpanded:
                                                                    true,
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff757575),
                                                                    fontSize:
                                                                        14.0),
                                                                items: station_data
                                                                    ?.map(
                                                                        (item) {
                                                                  return DropdownMenuItem(
                                                                    value: item[
                                                                            'where_id']
                                                                        .toString(),
                                                                    child: Text(
                                                                      item[
                                                                          'car_where'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            ('Bai Jamjuree'),
                                                                      ),
                                                                      textScaleFactor:
                                                                          1,
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                                onChanged:
                                                                    (String?
                                                                        newVal) {
                                                                  setState(() {
                                                                    Staid =
                                                                        newVal;
                                                                    StationController
                                                                            .text =
                                                                        Staid
                                                                            .toString();
                                                                    print(Staid
                                                                        .toString());
                                                                  });
                                                                },
                                                                value: Staid,
                                                              )),
                                                        ))),
                                                /*  Container(
                                                          child: Text(widget.QR),

                                                        ), */

                                                //<--------------------   Button -------------------->
                                                const SizedBox(height: 260),
                                                Center(
                                                  child: SizedBox(
                                                    height: 36.55,
                                                    width: 280,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary: const Color(
                                                              0xffE52628),
                                                          minimumSize: const Size
                                                              .fromHeight(40),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      onPressed: () =>
                                                          _CheckIn(context),
                                                      child: AutoSizeText(
                                                        'เช็คอินเข้าสถานี',
                                                        style: TextStyleBtn
                                                            .bodybtn,
                                                        maxFontSize: 12,
                                                        minFontSize: 11,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                            ))))),

                            //<--------------------   Foot -------------------->
                            const SizedBox(height: 10),
                            Text('Powered by Weise Technika',
                                style: TextStyleFoot.bodyfoot),
                          ]))))
        ])));
  }

  // < ------------------      Method        ------------------>
  //<--------------------   Alert -------------------->
  _CheckIn(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      image: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Image.asset('assets/images/iconalert.png'),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "ต้องการทำรายการ ?",
            style: TextStyleAlert.body18bold,
            textScaleFactor: 1,
          ),
          const SizedBox(height: 5),
          Text(
            "คุณต้องการทำรายการเช็คอิน",
            style: TextStyleAlert.body15normal,
            textScaleFactor: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.model.carid.car_chassis,
                style: TextStyleAlert.body15bold,
                textScaleFactor: 1,
              ),
              const SizedBox(width: 5),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "เข้าสถานีใช่หรือไม่",
                    style: TextStyleAlert.body15normal,
                    textScaleFactor: 1,
                  ),
                ],
              )
            ],
          ),
        ]),
      ),
      buttons: [
        DialogButton(
          onPressed: () async {
            setState(() {
              _fetchData(context);
            });
            ResponseModel response = await Putreq(
              StationController.text,
              "2",
            );

            if (response.success) {
              ResponseModel response2 = await HistoryPost().PostHis(
                widget.model.carid.car_id,
                DateFormat("yyyy-MM-dd").format(DateTime.now()),
                DateFormat.Hm().format(DateTime.now()),
                StationController.text,
                '1',
                "${userData['id']}",
              );
              if (response2.success) {
                ResponseModel response3 = await PutPosit("0", "1");
                if (response3.success) {
                  ResponseModel response4 = await Putperson("0");
                  if (response4.success) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckinSpach()));
                  }

                  /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CheckinSpach()),
                  ); */
                }

                /*  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CheckinSpach())); */
              }
            }
          },
          color: const Color(0xff44A73B),
          child: Text("ยืนยัน", style: TDialogButton.body14),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color(0xffE52628),
          child: Text("ยกเลิก", style: TDialogButton.body14),
        )
      ],
    ).show();
  }
}
_fetchData(BuildContext context, [bool mounted = true]) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        );
      });
}

//<--------------------   SplashScreen  -------------------->
/* class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/images/correct.json'),
      backgroundColor: Colors.red,
      nextScreen: const MenuPage(),
      splashIconSize: 150,
      duration: 2500,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(milliseconds: 50),
    );
    
  }
}
 */
