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
import 'package:vdqims/Service/Model/responsModel.dart';
import 'package:vdqims/SplashScreen/ReqSplash.dart';
import 'package:vdqims/Style/TextStyle.dart';
import '../../Service/API/PositionAPI.dart';
import '../../Service/API/PostReqApi.dart';
import '../../Service/Model/CarDBModel.dart';
import '../../Service/Model/HistoryModel.dart';
import '../../Service/Model/PositDBModel.dart';
import 'package:http/http.dart' as http;

class CardetailPage extends StatefulWidget {
  const CardetailPage({Key? key, required this.model}) : super(key: key);
  final CarDBAPI model;

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
    Future<List<HistoryDBAPI>> getreq() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');

      // response uri
      var response =
          await http.get(Uri.parse('https://vdqi-db.toyotaparagon.com/api/history/search/$carreq'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
      });
      // return value
      var req = HistoryDB.fromJson(jsonDecode(response.body));
      return req.data;
    }

    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(text: "รายละเอียดรถยนต์", style: TextStyleMenuName.bodyMenuThai, children: <TextSpan>[
                TextSpan(text: '\nCar Infomation', style: TextStyleMenuName.bodyMenuEng),
              ])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(Duration(milliseconds: 200), () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => FindcarPage()));
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 30,
            ),
          ),
          backgroundColor: baseColor1,
          elevation: 0,
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
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      //////////////// /* Card white */   ////////////////
                      SizedBox(
                          height: 650,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 12, spreadRadius: 5
                                        /*   offset: Offset(0, 3), */
                                        ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(children: <Widget>[
                                  //////////////// /* Card เลขตัวถัง */   ////////////////
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 10, spreadRadius: 2),
                                          ]),
                                      height: 85,
                                      child: ListTile(
                                        title: Text(
                                          widget.model.carChassis,
                                          style: const TextStyle(
                                            color: Color(0xff404040),
                                            fontFamily: ('IBM Plex Sans Thai'),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          textScaleFactor: 1,
                                        ),
                                        leading: AspectRatio(
                                          aspectRatio: 1,
                                          child: ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(1.0)),
                                              child: CircleAvatar(
                                                child: Image.asset(
                                                  'assets/images/car4.png',
                                                  height: 28.0,
                                                  width: 30,
                                                ),
                                                radius: 62.0,
                                                backgroundColor: (widget.model.carStatus.statusId == 1
                                                    ? const Color(0xff89EB80)
                                                    : const Color(0xffEB8080)),
                                              )),
                                        ),
                                        subtitle: Text(
                                          'รถยนต์ \n' + 'สถานะ :' + ' ' + widget.model.carStatus.carStatus,
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: SizedBox(
                                      height: 160,
                                      width: double.infinity,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 12, spreadRadius: 2
                                                  /*   offset: Offset(0, 3), */
                                                  ),
                                            ]),
                                        child: GestureDetector(
                                            onTap: () => FocusScope.of(context).unfocus(),
                                            child: Align(
                                                alignment: AlignmentDirectional(0, -0.1),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                                  child: Container(
                                                      height: 160,
                                                      child: Stack(children: [
                                                        Align(
                                                          alignment: AlignmentDirectional(-0.9, -0.9),
                                                          child: Text(
                                                            'สถานที่',
                                                            style: TextStyle(
                                                              color: Color(0xffD4D4D4),
                                                              fontSize: 16,
                                                              fontFamily: ('Bai Jamjuree'),
                                                            ),
                                                            textScaleFactor: 1,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: AlignmentDirectional(-0.05, -0.59),
                                                          child: Text(widget.model.carWhere.carWhere,
                                                              style: TextStyle(
                                                                color: Color(0xff404040),
                                                                fontSize: 36,
                                                                fontFamily: ('Kanit'),
                                                                fontWeight: FontWeight.w900,
                                                              ),
                                                              textScaleFactor: 1.0),
                                                        ),
                                                        Align(
                                                          alignment: AlignmentDirectional(-0.9, 0.1),
                                                          child: Text(
                                                            'แถว',
                                                            style: TextStyle(
                                                              color: Color(0xffD4D4D4),
                                                              fontSize: 16,
                                                              fontFamily: ('Bai Jamjuree'),
                                                            ),
                                                            textScaleFactor: 1,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: AlignmentDirectional(-0.56, 0.7),
                                                          child: Text(
                                                            widget.model.positId.car_status == 0
                                                                ? "-"
                                                                : widget.model.positId.line,
                                                            style: TextStyle(
                                                              color: Color(0xff404040),
                                                              fontSize: 36,
                                                              fontFamily: ('Kanit'),
                                                              fontWeight: FontWeight.w900,
                                                            ),
                                                            textScaleFactor: 1,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: AlignmentDirectional(0.1, 0.1),
                                                          child: Text(
                                                            'ลำดับ',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily: ('Bai Jamjuree'),
                                                              color: Color(0xffD4D4D4),
                                                            ),
                                                            textScaleFactor: 1,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: AlignmentDirectional(0.56, 0.7),
                                                          child: Text(
                                                            widget.model.positId.car_status == 0
                                                                ? "-"
                                                                : widget.model.positId.posit.toString(),
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                              fontWeight: FontWeight.w900,
                                                              fontFamily: ('Kanit'),
                                                            ),
                                                            textScaleFactor: 1,
                                                          ),
                                                        ),
                                                      ])),
                                                ))),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
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
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                                    child: SingleChildScrollView(
                                      child: FutureBuilder<List<HistoryDBAPI>>(
                                          future: getreq(),
                                          builder: (context, snapShot) {
                                            if (snapShot.hasData) {
                                              return SingleChildScrollView(
                                                child: Container(
                                                  height: 190,
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                                                    child: Container(
                                                      padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                                                      child: SingleChildScrollView(
                                                        child: DataTable(
                                                          headingRowHeight: 2,
                                                          horizontalMargin: 0,
                                                          columnSpacing: 0,
                                                          columns: const <DataColumn>[
                                                            DataColumn(
                                                                label: Expanded(
                                                              child: Text(
                                                                '',
                                                              ),
                                                            )),
                                                            DataColumn(
                                                                label: Expanded(
                                                              child: Text(
                                                                '',
                                                              ),
                                                            )),
                                                            DataColumn(
                                                                label: Expanded(
                                                              child: Text(
                                                                '',
                                                              ),
                                                            )),
                                                            DataColumn(
                                                                label: Expanded(
                                                              child: Text(
                                                                '',
                                                              ),
                                                            )),
                                                          ],
                                                          rows: snapShot.data!.map<DataRow>((e) {
                                                            return DataRow(
                                                              cells: <DataCell>[
                                                                DataCell(Text(
                                                                  '${e.date}',
                                                                  style: const TextStyle(
                                                                      fontSize: 14, fontFamily: ('Bai Jamjuree')),
                                                                  textScaleFactor: 1,
                                                                )),
                                                                DataCell(Text(
                                                                  '${e.carStatus.car_status}',
                                                                  style: const TextStyle(
                                                                      fontSize: 14, fontFamily: ('Bai Jamjuree')),
                                                                  textScaleFactor: 1,
                                                                )),
                                                                DataCell(Text(
                                                                  '${e.carWhere.carWhere}',
                                                                  style: const TextStyle(
                                                                      fontSize: 14, fontFamily: ('Bai Jamjuree')),
                                                                  textScaleFactor: 1,
                                                                )),
                                                                DataCell(Text(
                                                                  '${e.person.fullname}',
                                                                  style: const TextStyle(
                                                                      fontSize: 14, fontFamily: ('Bai Jamjuree')),
                                                                  textScaleFactor: 1,
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
                                  Center(
                                    child: SizedBox(
                                      width: 280,
                                      height: 36.55,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: const Color(0xffE52628),
                                            minimumSize: const Size.fromHeight(40),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                        onPressed: () => _request(context),
                                        child: AutoSizeText(
                                          'เบิกรถยนต์',
                                          style: TextStyleBtn.bodybtn,
                                          maxFontSize: 12,
                                          minFontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Center(
                                    child: SizedBox(
                                      width: 280,
                                      height: 36.55,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.cyan[900],
                                            minimumSize: const Size.fromHeight(40),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                        onPressed: () {
                                          if (widget.model.carWhere.whereId == 1) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => _DialogStockA(context),
                                            );
                                          } else if (widget.model.carWhere.whereId == 2) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => _DialogStockB(context),
                                            );
                                          } else if (widget.model.carWhere.whereId == 3) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => _DialogStockC(context),
                                            );
                                          } else if (widget.model.carWhere.whereId == 4) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => _DialogStockD(context),
                                            );
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    content: new Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Lottie.asset('assets/images/map.json',
                                                                  height: 150, width: 150),
                                                              Center(
                                                                  child: Text('รถกำลังดำเนินการที่',
                                                                      style: TextStyleAlert.body16bold)),
                                                              Center(
                                                                  child: Text(widget.model.carWhere.carWhere,
                                                                      style: TextStyleAlert.body16)),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      Center(
                                                        child: SizedBox(
                                                          width: 280,
                                                          height: 36.55,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                primary: const Color(0xffE52628),
                                                                minimumSize: const Size.fromHeight(40),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(12))),
                                                            child: AutoSizeText(
                                                              'ตกลง',
                                                              style: TextStyleBtn.bodybtn,
                                                              maxFontSize: 12,
                                                              minFontSize: 11,
                                                            ),
                                                          ),
                                                        ),
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
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          )),

                      const SizedBox(height: 10),
                      Text('Powered by Weise Technika', style: TextStyleFoot.bodyfoot, textScaleFactor: 1.0),
                    ])),
              ),
            )
          ]),
        ));
  }

// <------------------------- Dialog Stock  -------------------------->
  Widget _DialogStockA(BuildContext context) {
    return new AlertDialog(
      insetPadding: EdgeInsets.zero,
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Text('แผนผังแสดงลานจอด ลานดิน ', style: TextStyleAlert.body16bold)),
                Center(
                  child: _buildStockA(),
                )
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
            width: 280,
            height: 36.55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xffE52628),
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: AutoSizeText(
                'ตกลง',
                style: TextStyleBtn.bodybtn,
                maxFontSize: 12,
                minFontSize: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _DialogStockB(BuildContext context) {
    return new AlertDialog(
      insetPadding: EdgeInsets.zero,
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Text('แผนผังแสดงลานจอด Stock A ', style: TextStyleAlert.body16bold)),
                Center(
                  child: _buildStockB(),
                )
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
            width: 280,
            height: 36.55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xffE52628),
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: AutoSizeText(
                'ตกลง',
                style: TextStyleBtn.bodybtn,
                maxFontSize: 12,
                minFontSize: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _DialogStockC(BuildContext context) {
    return new AlertDialog(
      insetPadding: EdgeInsets.zero,
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Text('แผนผังแสดงลานจอด Stock B ', style: TextStyleAlert.body16bold)),
                Center(
                  child: _buildStockC(),
                )
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
            width: 280,
            height: 36.55,
            child: new ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xffE52628),
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: AutoSizeText(
                'ตกลง',
                style: TextStyleBtn.bodybtn,
                maxFontSize: 12,
                minFontSize: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _DialogStockD(BuildContext context) {
    return new AlertDialog(
      insetPadding: EdgeInsets.zero,
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Text('แผนผังแสดงลานจอด Stock C ', style: TextStyleAlert.body16bold)),
                Center(
                  child: _buildStockD(),
                )
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
            width: 280,
            height: 36.55,
            child: new ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xffE52628),
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: AutoSizeText(
                'ตกลง',
                style: TextStyleBtn.bodybtn,
                maxFontSize: 12,
                minFontSize: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }

// <------------------------- Stock  -------------------------->
  Widget _buildStockA() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffE2E8F0))),
      height: 395,
      width: 290,
      child: Column(children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
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
                                  height: 330,
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
                            padding: const EdgeInsets.only(left: 5, right: 10),
                            child: Container(
                                height: 350,
                                child: FutureBuilder(
                                    future: PostionService().getWhere1(),
                                    builder: (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                                      if (snapshot.hasData) {
                                        List<PositDBAPI>? data = snapshot.data;
                                        return Container(
                                            width: 20,
                                            height: 20,
                                            child: GridView.builder(
                                                padding: const EdgeInsets.all(10),
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                      color: (data[index].carid.car_id == widget.model.carId &&
                                                              data[index].car_status == 1
                                                          ? Colors.blue
                                                          : data[index].car_status == 1
                                                              ? Colors.red
                                                              : data[index].car_status == 2
                                                                  ? Colors.grey
                                                                  : const Color(0xff89EB80)),
                                                      borderRadius: BorderRadius.circular(0),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return new AlertDialog(
                                                                content: new Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    SingleChildScrollView(
                                                                        child: Column(
                                                                      children: [
                                                                        Center(
                                                                          child: Lottie.asset('assets/images/map.json',
                                                                              height: 150, width: 150),
                                                                        ),
                                                                        Center(
                                                                            child: Container(
                                                                          height: 80,
                                                                          width: 500,
                                                                          child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text("เลขตัวถัง ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].carid.car_chassis}",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text("ประเภท  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text("รถยนต์",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              /*  Row(
                                                                                children: [
                                                                                  Text("สี  ", textScaleFactor: 1, style: TextStyleAlert.body16bold),
                                                                                  Text("แดง", textScaleFactor: 1, style: TextStyleAlert.body16),
                                                                                ],
                                                                              ), */
                                                                              Row(
                                                                                children: [
                                                                                  Text("ตำแหน่ง :  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].line}${data[index].posit}  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text("ลานจอด :  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].carWhere.carWhere} ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ))
                                                                      ],
                                                                    ))
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  Center(
                                                                    child: SizedBox(
                                                                      width: 280,
                                                                      height: 36.55,
                                                                      child: ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: const Color(0xffE52628),
                                                                            minimumSize: const Size.fromHeight(40),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                    BorderRadius.circular(12))),
                                                                        child: AutoSizeText(
                                                                          'ตกลง',
                                                                          style: TextStyleBtn.bodybtn,
                                                                          maxFontSize: 12,
                                                                          minFontSize: 11,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
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
                                                }));
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.red,
                                        ),
                                      );
                                    })),
                          ),
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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffE2E8F0))),
      height: 395,
      width: 290,
      child: Column(children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
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
                                  height: 330,
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
                            padding: const EdgeInsets.only(left: 1, right: 5),
                            child: Container(
                                height: 350,
                                child: FutureBuilder(
                                    future: PostionService().getWhere2(),
                                    builder: (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                                      if (snapshot.hasData) {
                                        List<PositDBAPI>? data = snapshot.data;
                                        return Container(
                                            width: 20,
                                            height: 20,
                                            child: GridView.builder(
                                                padding: const EdgeInsets.all(10),
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                      color: (data[index].carid.car_id == widget.model.carId &&
                                                              data[index].car_status == 1
                                                          ? Colors.blue
                                                          : data[index].car_status == 1
                                                              ? Colors.red
                                                              : data[index].car_status == 2
                                                                  ? Colors.grey
                                                                  : const Color(0xff89EB80)),
                                                      borderRadius: BorderRadius.circular(0),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return new AlertDialog(
                                                                content: new Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    SingleChildScrollView(
                                                                        child: Column(
                                                                      children: [
                                                                        Center(
                                                                          child: Lottie.asset('assets/images/map.json',
                                                                              height: 150, width: 150),
                                                                        ),
                                                                        Center(
                                                                            child: Container(
                                                                          height: 80,
                                                                          width: 500,
                                                                          child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text("เลขตัวถัง ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].carid.car_chassis}",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text("ประเภท  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text("รถยนต์",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              /*  Row(
                                                                                children: [
                                                                                  Text("สี  ", textScaleFactor: 1, style: TextStyleAlert.body16bold),
                                                                                  Text("แดง", textScaleFactor: 1, style: TextStyleAlert.body16),
                                                                                ],
                                                                              ), */
                                                                              Row(
                                                                                children: [
                                                                                  Text("ตำแหน่ง :  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].line}${data[index].posit}  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text("ลานจอด :  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].carWhere.carWhere} ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ))
                                                                      ],
                                                                    ))
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  Center(
                                                                    child: SizedBox(
                                                                      width: 280,
                                                                      height: 36.55,
                                                                      child: new ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: const Color(0xffE52628),
                                                                            minimumSize: const Size.fromHeight(40),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                    BorderRadius.circular(10))),
                                                                        child: AutoSizeText(
                                                                          'ตกลง',
                                                                          style: TextStyleBtn.bodybtn,
                                                                          maxFontSize: 12,
                                                                          minFontSize: 11,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
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
                                                }));
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.red,
                                        ),
                                      );
                                    })),
                          ),
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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffE2E8F0))),
      height: 395,
      width: 290,
      child: Column(children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
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
                                  height: 330,
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
                            padding: const EdgeInsets.only(left: 1, right: 5),
                            child: Container(
                                height: 350,
                                child: FutureBuilder(
                                    future: PostionService().getWhere3(),
                                    builder: (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                                      if (snapshot.hasData) {
                                        List<PositDBAPI>? data = snapshot.data;
                                        return Container(
                                            width: 20,
                                            height: 20,
                                            child: GridView.builder(
                                                padding: const EdgeInsets.all(10),
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                      color: (data[index].carid.car_id == widget.model.carId &&
                                                              data[index].car_status == 1
                                                          ? Colors.blue
                                                          : data[index].car_status == 1
                                                              ? Colors.red
                                                              : data[index].car_status == 2
                                                                  ? Colors.grey
                                                                  : const Color(0xff89EB80)),
                                                      borderRadius: BorderRadius.circular(0),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return new AlertDialog(
                                                                content: new Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    SingleChildScrollView(
                                                                        child: Column(
                                                                      children: [
                                                                        Center(
                                                                          child: Lottie.asset('assets/images/map.json',
                                                                              height: 150, width: 150),
                                                                        ),
                                                                        Center(
                                                                            child: Container(
                                                                          height: 80,
                                                                          width: 500,
                                                                          child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text("เลขตัวถัง ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].carid.car_chassis}",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text("ประเภท  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text("รถยนต์",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              /*  Row(
                                                                                children: [
                                                                                  Text("สี  ", textScaleFactor: 1, style: TextStyleAlert.body16bold),
                                                                                  Text("แดง", textScaleFactor: 1, style: TextStyleAlert.body16),
                                                                                ],
                                                                              ), */
                                                                              Row(
                                                                                children: [
                                                                                  Text("ตำแหน่ง :  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].line}${data[index].posit}  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text("ลานจอด :  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].carWhere.carWhere} ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ))
                                                                      ],
                                                                    ))
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  Center(
                                                                    child: SizedBox(
                                                                      width: 280,
                                                                      height: 36.55,
                                                                      child: new ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: const Color(0xffE52628),
                                                                            minimumSize: const Size.fromHeight(40),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                    BorderRadius.circular(10))),
                                                                        child: AutoSizeText(
                                                                          'ตกลง',
                                                                          style: TextStyleBtn.bodybtn,
                                                                          maxFontSize: 12,
                                                                          minFontSize: 11,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
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
                                                }));
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.red,
                                        ),
                                      );
                                    })),
                          ),
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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffE2E8F0))),
      height: 395,
      width: 290,
      child: Column(children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
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
                                  height: 330,
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
                            padding: const EdgeInsets.only(left: 1, right: 5),
                            child: Container(
                                height: 350,
                                child: FutureBuilder(
                                    future: PostionService().getWhere4(),
                                    builder: (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                                      if (snapshot.hasData) {
                                        List<PositDBAPI>? data = snapshot.data;
                                        return Container(
                                            width: 20,
                                            height: 20,
                                            child: GridView.builder(
                                                padding: const EdgeInsets.all(10),
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                      color: (data[index].carid.car_id == widget.model.carId &&
                                                              data[index].car_status == 1
                                                          ? Colors.blue
                                                          : data[index].car_status == 1
                                                              ? Colors.red
                                                              : data[index].car_status == 2
                                                                  ? Colors.grey
                                                                  : const Color(0xff89EB80)),
                                                      borderRadius: BorderRadius.circular(0),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return new AlertDialog(
                                                                content: new Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    SingleChildScrollView(
                                                                        child: Column(
                                                                      children: [
                                                                        Center(
                                                                          child: Lottie.asset('assets/images/map.json',
                                                                              height: 150, width: 150),
                                                                        ),
                                                                        Center(
                                                                            child: Container(
                                                                          height: 80,
                                                                          width: 500,
                                                                          child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text("เลขตัวถัง ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].carid.car_chassis}",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text("ประเภท  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text("รถยนต์",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              /*  Row(
                                                                                children: [
                                                                                  Text("สี  ", textScaleFactor: 1, style: TextStyleAlert.body16bold),
                                                                                  Text("แดง", textScaleFactor: 1, style: TextStyleAlert.body16),
                                                                                ],
                                                                              ), */
                                                                              Row(
                                                                                children: [
                                                                                  Text("ตำแหน่ง :  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].line}${data[index].posit}  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text("ลานจอด :  ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16bold),
                                                                                  Text(
                                                                                      "${data[index].carWhere.carWhere} ",
                                                                                      textScaleFactor: 1,
                                                                                      style: TextStyleAlert.body16),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ))
                                                                      ],
                                                                    ))
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  Center(
                                                                    child: SizedBox(
                                                                      width: 280,
                                                                      height: 36.55,
                                                                      child: new ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: const Color(0xffE52628),
                                                                            minimumSize: const Size.fromHeight(40),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                    BorderRadius.circular(10))),
                                                                        child: AutoSizeText(
                                                                          'ตกลง',
                                                                          style: TextStyleBtn.bodybtn,
                                                                          maxFontSize: 12,
                                                                          minFontSize: 11,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
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
                                                }));
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.red,
                                        ),
                                      );
                                    })),
                          ),
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
          SizedBox(height: 8),
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
            setState(() {
              _fetchData(context);
            });
            ResponseModel response = await ReqAPIDB().PostReq(
              widget.model.carId,
              DateFormat("yyyy-MM-dd").format(DateTime.now()),
              DateFormat.Hm().format(DateTime.now()),
              "${userData['id']}",
            );

            if (response.success) {
              ResponseModel respones1 = await PutCar(
                "2",
                widget.model.carWhere.whereId.toString(),
              );

              if (respones1.success) {
                ResponseModel response2 = await HistoryPost().PostHis(
                  widget.model.carId,
                  DateFormat("yyyy-MM-dd").format(DateTime.now()),
                  DateFormat.Hm().format(DateTime.now()),
                  widget.model.carWhere.whereId.toString(),
                  "2",
                  "${userData['id']}",
                );

                if (response2.success) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Reqsplash()));
                }
                /* Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Reqsplash())); */
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

  // <------------------------ updateposition ------------------------>
  dynamic urlup = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> PutCar(
    dynamic car_status,
    dynamic car_where,
  ) async {
    try {
      Map<String, String> data = {
        'car_status': car_status,
        'car_where': car_where,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      /*  var ID = localStorage.getString('ID'); */
      var IDCAR = widget.model.carId;
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'};
      if (_authToken != null) {
        urlup = Uri.parse("https://vdqi-db.toyotaparagon.com/api/cardb/$IDCAR");
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
