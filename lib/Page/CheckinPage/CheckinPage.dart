import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import 'package:http/http.dart' as http;
import 'package:vdqims/Service/API/PositionAPI.dart';
import 'package:vdqims/SplashScreen/CheckinSplash.dart';

import '../../Service/API/PostReqApi.dart';
import '../../Service/Model/PositDBModel.dart';
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
  late Future<List<PositDBAPI>> _future;

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
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'};
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
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'};
      if (_authToken != null) {
        urlup1 = Uri.parse("https://vdqi-db.toyotaparagon.com/api/posit/$carID");
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
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'};
      if (_authToken != null) {
        urlup2 = Uri.parse("https://vdqi-db.toyotaparagon.com/api/reqDB/$reqID");
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

  // <------------------------ updatereq ------------------------>
  dynamic urlup4 = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> UpdateCar(
    dynamic car_status,
    dynamic car_where,
    dynamic posit_id,
  ) async {
    try {
      Map<String, String> data = {
        'car_status': car_status,
        'car_where': car_where,
        'posit_id': posit_id,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      var carID = localStorage.getString('carID');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'};
      if (_authToken != null) {
        urlup = Uri.parse("https://vdqi-db.toyotaparagon.com/api/update/car/$carID");
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

  //<--------------------   get Dropdown Station -------------------->

  List? station_data;
  String? Staid;
  String? itesmvalue;
  var userData;
  String? selected = "";
  String? line = "";
  String? sort = "";

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

  dynamic Test = '';
  //<--------------------   Controller -------------------->
  TextEditingController StationController = TextEditingController();
  TextEditingController PositController = TextEditingController();
  TextEditingController lineController = TextEditingController();
  TextEditingController WhereController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.station();
    _getUserInfo();
    _future = PostionService().getpositionStockB();
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
              text: TextSpan(text: "เช็คอินเข้าสถานี", style: TextStyleMenuName.bodyMenuThai, children: <TextSpan>[
                TextSpan(text: '\nCheck in', style: TextStyleMenuName.bodyMenuEng),
              ])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MycarsPage()));
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
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        SizedBox(
                            height: 550,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 12, spreadRadius: 5
                                              /*   offset: Offset(0, 3), */
                                              ),
                                        ]),
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SingleChildScrollView(
                                          child: Column(children: <Widget>[
                                            //<--------------------   Container Card Chassis -------------------->
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                              child: Container(
                                                height: 85,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(12),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                                          blurRadius: 10,
                                                          spreadRadius: 2),
                                                    ]),
                                                child: ListTile(
                                                  title: Text(
                                                    widget.model.carid.car_chassis,
                                                    style: TextStyleinfor.bodyinfor18,
                                                    textScaleFactor: 1,
                                                  ),
                                                  leading: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: ClipRRect(
                                                      borderRadius: const BorderRadius.all(Radius.circular(1.0)),
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
                                            //<--------------------   CheckIn -------------------->
                                            const SizedBox(height: 20),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    'ข้อมูลการเช็คอิน',
                                                    style: TextStyleCheckin.bodyCheckin20,
                                                    textScaleFactor: 1,
                                                  )),
                                            ),
                                            //<--------------------   Station -------------------->
                                            const SizedBox(height: 8),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    'สถานี',
                                                    style: TextStyleCheckin.bodyCheckin16,
                                                    textScaleFactor: 1,
                                                  )),
                                            ),
                                            //<--------------------   DropDown -------------------->
                                            Padding(
                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color(0xffE2E8F0),
                                                        ),
                                                        borderRadius: BorderRadius.circular(5.5)),
                                                    child: Container(
                                                      height: 35.2,
                                                      child: Padding(
                                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                                          child: DropdownButton(
                                                            hint: Text(
                                                              'กรุณาเลือกสถานี',
                                                              style: TextStyleCheckin.bodyCheckin16,
                                                              textScaleFactor: 1,
                                                            ),
                                                            elevation: 10,
                                                            icon: const Icon(Icons.arrow_drop_down),
                                                            iconSize: 13.0,
                                                            isExpanded: true,
                                                            style: const TextStyle(
                                                                color: Color(0xff757575), fontSize: 14.0),
                                                            items: station_data?.map((item) {
                                                              return DropdownMenuItem(
                                                                value: item['where_id'].toString(),
                                                                child: Text(
                                                                  item['car_where'],
                                                                  style: const TextStyle(
                                                                    fontFamily: ('Bai Jamjuree'),
                                                                  ),
                                                                  textScaleFactor: 1,
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String? newVal) {
                                                              setState(() {
                                                                Staid = newVal;
                                                                StationController.text = Staid.toString();
                                                                print(Staid.toString());
                                                              });
                                                            },
                                                            value: Staid,
                                                          )),
                                                    ))),

                                            //<--------------------   return  ลานดิน -------------------->

                                            if (Staid == '16')
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            if (Staid == '16')
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(color: const Color(0xffE2E8F0))),
                                                  height: 360,
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 25),
                                                    ),
                                                    Expanded(
                                                        child: FutureBuilder(
                                                            future: _future,
                                                            builder: (BuildContext context,
                                                                AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                                                              if (snapshot.hasData) {
                                                                List<PositDBAPI>? data = snapshot.data;
                                                                return StockA();
                                                              }
                                                              return Text('data');
                                                            }))
                                                  ]),
                                                ),
                                              ),
                                            if (Staid == '16') const SizedBox(height: 10),
                                            if (Staid == '16')
                                              Center(
                                                child: SizedBox(
                                                  height: 36.55,
                                                  width: 280,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: const Color(0xffE52628),
                                                        minimumSize: const Size.fromHeight(40),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10))),
                                                    onPressed: () => _CheckIn(context),
                                                    child: AutoSizeText(
                                                      'เช็คอินเข้าสถานี',
                                                      style: TextStyleBtn.bodybtn,
                                                      maxFontSize: 12,
                                                      minFontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            //<--------------------   return ใกล้ลานดิน -------------------->
                                            if (Staid == '17')
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            if (Staid == '17')
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(color: const Color(0xffE2E8F0))),
                                                  height: 360,
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 25),
                                                    ),
                                                    Expanded(
                                                        child: FutureBuilder(
                                                            future: _future,
                                                            builder: (BuildContext context,
                                                                AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                                                              if (snapshot.hasData) {
                                                                List<PositDBAPI>? data = snapshot.data;
                                                                return StockB();
                                                              }
                                                              return Text('data');
                                                            }))
                                                  ]),
                                                ),
                                              ),
                                            if (Staid == '17') const SizedBox(height: 10),
                                            if (Staid == '17')
                                              Center(
                                                child: SizedBox(
                                                  height: 36.55,
                                                  width: 280,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: const Color(0xffE52628),
                                                        minimumSize: const Size.fromHeight(40),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10))),
                                                    onPressed: () => _CheckIn(context),
                                                    child: AutoSizeText(
                                                      'เช็คอินเข้าสถานี',
                                                      style: TextStyleBtn.bodybtn,
                                                      maxFontSize: 12,
                                                      minFontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            //<--------------------   return  ลานดิน 2 -------------------->
                                            if (Staid == '18')
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            if (Staid == '18')
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(color: const Color(0xffE2E8F0))),
                                                  height: 360,
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 25),
                                                    ),
                                                    Expanded(
                                                        child: FutureBuilder(
                                                            future: _future,
                                                            builder: (BuildContext context,
                                                                AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                                                              if (snapshot.hasData) {
                                                                List<PositDBAPI>? data = snapshot.data;
                                                                return StockC();
                                                              }
                                                              return Text('data');
                                                            }))
                                                  ]),
                                                ),
                                              ),
                                            if (Staid == '18') const SizedBox(height: 10),
                                            if (Staid == '18')
                                              Center(
                                                child: SizedBox(
                                                  height: 36.55,
                                                  width: 280,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: const Color(0xffE52628),
                                                        minimumSize: const Size.fromHeight(40),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10))),
                                                    onPressed: () => _CheckIn(context),
                                                    child: AutoSizeText(
                                                      'เช็คอินเข้าสถานี',
                                                      style: TextStyleBtn.bodybtn,
                                                      maxFontSize: 12,
                                                      minFontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            //<--------------------   return  ลานดิน 3 -------------------->
                                            if (Staid == '19')
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            if (Staid == '19')
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(color: const Color(0xffE2E8F0))),
                                                  height: 360,
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 25),
                                                    ),
                                                    Expanded(
                                                        child: FutureBuilder(
                                                            future: _future,
                                                            builder: (BuildContext context,
                                                                AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                                                              if (snapshot.hasData) {
                                                                List<PositDBAPI>? data = snapshot.data;
                                                                return StockD();
                                                              }
                                                              return Text('data');
                                                            }))
                                                  ]),
                                                ),
                                              ),
                                            if (Staid == '19') const SizedBox(height: 10),
                                            if (Staid == '19')
                                              Center(
                                                child: SizedBox(
                                                  height: 36.55,
                                                  width: 280,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: const Color(0xffE52628),
                                                        minimumSize: const Size.fromHeight(40),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10))),
                                                    onPressed: () => _CheckIn(context),
                                                    child: AutoSizeText(
                                                      'เช็คอินเข้าสถานี',
                                                      style: TextStyleBtn.bodybtn,
                                                      maxFontSize: 12,
                                                      minFontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (Staid != '16' && Staid != '17' && Staid != '18' && Staid != '19')
                                              const SizedBox(height: 260),
                                            if (Staid != '16' && Staid != '17' && Staid != '18' && Staid != '19')
                                              Center(
                                                child: SizedBox(
                                                  height: 36.55,
                                                  width: 280,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: const Color(0xffE52628),
                                                        minimumSize: const Size.fromHeight(40),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10))),
                                                    onPressed: () => _CheckIn(context),
                                                    child: AutoSizeText(
                                                      'เช็คอินเข้าสถานี',
                                                      style: TextStyleBtn.bodybtn,
                                                      maxFontSize: 12,
                                                      minFontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            //<--------------------   Button -------------------->
                                            /* const SizedBox(height: 100),
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
                                                ) */
                                          ]),
                                        ))))),

                        //<--------------------   Foot -------------------->
                        const SizedBox(height: 10),
                        Text('Powered by Weise Technika', style: TextStyleFoot.bodyfoot),
                      ]))))
        ])));
  }

  void _Position(BuildContext context) async {
    Text('กรุณาเลือกสถานี');
  }

  Widget StockA() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                "ลานดิน",
                style: TextStyleAlert.body18bold,
                textScaleFactor: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "A",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "B",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "C",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "D",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        Container(
                            height: 285,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(246, 231, 230, 236),
                              ),
                              color: const Color.fromARGB(246, 231, 230, 236),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: const Center(
                              child: RotatedBox(quarterTurns: 1, child: Text("Lotus")),
                            ))
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 25),
                      child: Container(
                        height: 285,
                        width: double.infinity,

                        /*  child: Stock()), */
                        child: FutureBuilder(
                            future: PostionService().getWhere1(),
                            builder: (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                              if (snapshot.hasData) {
                                List<PositDBAPI>? data = snapshot.data;
                                return Container(
                                  child: GridView.builder(
                                      padding: const EdgeInsets.all(2),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 4,
                                      ),
                                      itemCount: data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: (data[index].car_status == 1
                                                ? Colors.red
                                                : data[index].car_status == 2
                                                    ? Colors.grey
                                                    : sort == data[index].sort.toString()
                                                        ? Colors.yellow
                                                        : const Color(0xff89EB80)),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              dynamic Idposit = data[index].posit_id.toString();

                                              SharedPreferences localStorage = await SharedPreferences.getInstance();
                                              localStorage.setString('ID', Idposit);

                                              setState(() {
                                                if (data[index].car_status == 1) {
                                                  selected = '';
                                                  line = '';
                                                  sort = '';
                                                } else if (data[index].car_status == 2) {
                                                  selected = '';
                                                  line = '';
                                                  sort = '';
                                                } else {
                                                  selected = data[index].posit.toString();
                                                  line = data[index].line.toString();
                                                  sort = data[index].sort.toString();

                                                  PositController.text = Idposit.toString();

                                                  lineController.text = line.toString();

                                                  print(data[index].posit);
                                                  print(data[index].line);
                                                }
                                              });
                                            },
                                            onDoubleTap: () {
                                              setState(() {
                                                selected = '';
                                                line = '';
                                                sort = '';
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                textScaleFactor: 1,
                                                data[index].posit.toString(),
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget StockB() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                "Stock A ใกล้ลานดิน",
                style: TextStyleAlert.body18bold,
                textScaleFactor: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "A",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "B",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "C",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "D",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "E",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        Container(
                            height: 285,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(246, 231, 230, 236),
                              ),
                              color: const Color.fromARGB(246, 231, 230, 236),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: const Center(
                              child: RotatedBox(quarterTurns: 1, child: Text("Lotus")),
                            ))
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 12),
                      child: Container(
                        child: FutureBuilder(
                            future: PostionService().getWhere2(),
                            builder: (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                              if (snapshot.hasData) {
                                List<PositDBAPI>? data = snapshot.data;
                                return Container(
                                  child: GridView.builder(
                                      padding: const EdgeInsets.all(2),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 5,
                                      ),
                                      itemCount: data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: (data[index].car_status == 1
                                                ? Colors.red
                                                : data[index].car_status == 2
                                                    ? Colors.grey
                                                    : sort == data[index].sort.toString()
                                                        ? Colors.yellow
                                                        : const Color(0xff89EB80)),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              dynamic Idposit = data[index].posit_id.toString();

                                              SharedPreferences localStorage = await SharedPreferences.getInstance();
                                              localStorage.setString('ID', Idposit);

                                              setState(() {
                                                if (data[index].car_status == 1) {
                                                  selected = '';
                                                  line = '';
                                                  sort = '';
                                                } else if (data[index].car_status == 2) {
                                                  selected = '';
                                                  line = '';
                                                  sort = '';
                                                } else {
                                                  selected = data[index].posit.toString();
                                                  line = data[index].line.toString();
                                                  sort = data[index].sort.toString();

                                                  PositController.text = Idposit.toString();

                                                  lineController.text = line.toString();

                                                  print(data[index].posit);
                                                  print(data[index].line);
                                                }
                                              });
                                            },
                                            onDoubleTap: () {
                                              setState(() {
                                                selected = '';
                                                line = '';
                                                sort = '';
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                textScaleFactor: 1,
                                                data[index].posit.toString(),
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget StockC() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                "Stock B (Stock VDQI)",
                style: TextStyleAlert.body18bold,
                textScaleFactor: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.white,
                    height: 30,
                    width: 30,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "A",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "B",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "C",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "D",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "E",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        Container(
                            height: 285,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(246, 231, 230, 236),
                              ),
                              color: const Color.fromARGB(246, 231, 230, 236),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: const Center(
                              child: RotatedBox(quarterTurns: 1, child: Text("Lotus")),
                            ))
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 12),
                      child: Container(
                        child: FutureBuilder(
                            future: PostionService().getWhere3(),
                            builder: (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                              if (snapshot.hasData) {
                                List<PositDBAPI>? data = snapshot.data;
                                return Container(
                                  child: GridView.builder(
                                      padding: const EdgeInsets.all(2),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 5,
                                      ),
                                      itemCount: data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: (data[index].car_status == 1
                                                ? Colors.red
                                                : data[index].car_status == 2
                                                    ? Colors.grey
                                                    : sort == data[index].sort.toString()
                                                        ? Colors.yellow
                                                        : const Color(0xff89EB80)),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              dynamic Idposit = data[index].posit_id.toString();

                                              SharedPreferences localStorage = await SharedPreferences.getInstance();
                                              localStorage.setString('ID', Idposit);

                                              setState(() {
                                                if (data[index].car_status == 1) {
                                                  selected = '';
                                                  line = '';
                                                  sort = '';
                                                } else if (data[index].car_status == 2) {
                                                  selected = '';
                                                  line = '';
                                                  sort = '';
                                                } else {
                                                  selected = data[index].posit.toString();
                                                  line = data[index].line.toString();
                                                  sort = data[index].sort.toString();

                                                  PositController.text = Idposit.toString();

                                                  lineController.text = line.toString();

                                                  print(data[index].posit);
                                                  print(data[index].line);
                                                }
                                              });
                                            },
                                            onDoubleTap: () {
                                              setState(() {
                                                selected = '';
                                                line = '';
                                                sort = '';
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                textScaleFactor: 1,
                                                data[index].posit.toString(),
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget StockD() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                "Stock C (No.1)",
                style: TextStyleAlert.body18bold,
                textScaleFactor: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.white,
                    height: 30,
                    width: 30,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "A",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "B",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "C",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "D",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "E",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        Container(
                            height: 285,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(246, 231, 230, 236),
                              ),
                              color: const Color.fromARGB(246, 231, 230, 236),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: const Center(
                              child: RotatedBox(quarterTurns: 1, child: Text("Lotus")),
                            ))
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 12),
                      child: Container(
                        child: FutureBuilder(
                            future: PostionService().getWhere4(),
                            builder: (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                              if (snapshot.hasData) {
                                List<PositDBAPI>? data = snapshot.data;
                                return Container(
                                  child: GridView.builder(
                                      padding: const EdgeInsets.all(2),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 5,
                                      ),
                                      itemCount: data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: (data[index].car_status == 1
                                                ? Colors.red
                                                : data[index].car_status == 2
                                                    ? Colors.grey
                                                    : sort == data[index].sort.toString()
                                                        ? Colors.yellow
                                                        : const Color(0xff89EB80)),
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              dynamic Idposit = data[index].posit_id.toString();

                                              SharedPreferences localStorage = await SharedPreferences.getInstance();
                                              localStorage.setString('ID', Idposit);

                                              setState(() {
                                                if (data[index].car_status == 1) {
                                                  selected = '';
                                                  line = '';
                                                  sort = '';
                                                } else if (data[index].car_status == 2) {
                                                  selected = '';
                                                  line = '';
                                                  sort = '';
                                                } else {
                                                  selected = data[index].posit.toString();
                                                  line = data[index].line.toString();
                                                  sort = data[index].sort.toString();

                                                  PositController.text = Idposit.toString();

                                                  lineController.text = line.toString();

                                                  print(data[index].posit);
                                                  print(data[index].line);
                                                }
                                              });
                                            },
                                            onDoubleTap: () {
                                              setState(() {
                                                selected = '';
                                                line = '';
                                                sort = '';
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                textScaleFactor: 1,
                                                data[index].posit.toString(),
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
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
            if (Staid == '16') {
              ResponseModel response1 = await UpdateCar(
                "1",
                "1",
                PositController.text,
              );
              if (response1.success) {
                ResponseModel response2 = await HistoryPost().PostHis(
                  widget.model.carid.car_id,
                  DateFormat("yyyy-MM-dd").format(DateTime.now()),
                  DateFormat.Hm().format(DateTime.now()),
                  StationController.text,
                  '1',
                  "${userData['id']}",
                );
                if (response2.success) {
                  ResponseModel response4 = await Putperson("0");
                  if (response4.success) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckinSpach()));
                  }
                }
              }

              /* 
            );
            if (response.success) {
              //UpdateCar
              ResponseModel response1 = await UpdateCar(
              "1",
              WhereController.text,
              widget.model.carid.car_id,
            );
            if(response1.success){
              ResponseModel response2 = await HistoryPost().PostHis(
                widget.model.carid.car_id,
                DateFormat("yyyy-MM-dd").format(DateTime.now()),
                DateFormat.Hm().format(DateTime.now()),
                StationController.text,
                '1',
                "${userData['id']}",
              );
              if (response2.success) {
                ResponseModel response3 = await PutPosit("1", widget.model.carid.car_id);
                if (response3.success) {
                  ResponseModel response4 = await Putperson("0");
                  if (response4.success) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckinSpach()));
                  }
                }
              }

            }
            

              
            } */
            } else {
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckinSpach()));
                    }
                  }
                }
              }
            }

            /*  ResponseModel response = await Putreq(
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
                }
              }
            } */
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
