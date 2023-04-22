// ignore_for_file: unnecessary_new, unnecessary_const

import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Service/API/PositionAPI.dart';
import 'package:vdqims/Style/TextStyle.dart';
import 'package:http/http.dart' as http;
import '../../Service/API/PostCarDB.dart';
import '../../Service/Model/PositDBModel.dart';
import '../../SplashScreen/AddnewSplash.dart';
import '../../Service/Model/responsModel.dart';
import '../MenuPage/MenuPage.dart';

class AddnewcarPage extends StatefulWidget {
  const AddnewcarPage({Key? key}) : super(key: key);

  @override
  State<AddnewcarPage> createState() => _AddnewcarPageState();
}

class _AddnewcarPageState extends State<AddnewcarPage> {
  late Future<List<PositDBAPI>> _future;

  // <------------------------ updateposition ------------------------>
  dynamic urlup = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> PutPosition(
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
      var IDposit = localStorage.getString('ID');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'};
      if (_authToken != null) {
        urlup = Uri.parse("https://vdqi-db.toyotaparagon.com/api/posit/$IDposit");
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

  // <------------------------ ตัวแปร ------------------------>
  String? selected = "";
  String? line = "";
  String? sort = "";
  /*  String? line = ""; */
  List? where_data;
  String? Whereid;
  String qrCode = '';
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  var userData;
  var carData;

// <------------------------ Service ------------------------>
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);

    setState(() {
      userData = user;
    });
  }
  /* void _CarInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var carJson = localStorage.getString('car');
    var car = json.decode(carJson!);
    setState(() {
      carData = car;
    });
  } */

  var url = Uri.encodeFull('https://vdqi-db.toyotaparagon.com/api/where/s/0');
  Future<String> where() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');
    var res = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $_authToken',
    });
    var resBody = json.decode(res.body);

    setState(() {
      where_data = resBody;
    });
    return "Sucess";
  }

  // <------------------------ Controller ------------------------>

  TextEditingController StationController = TextEditingController();
  TextEditingController ChassisController = TextEditingController();
  TextEditingController WhereController = TextEditingController();
  TextEditingController PositController = TextEditingController();
  TextEditingController lineController = TextEditingController();

  // <------------------------ Function ------------------------>
  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      qrCode = barcodeScanRes;
      ChassisController.text = qrCode;
    });
  }

  @override
  void initState() {
    super.initState();
    this.where();
    _getUserInfo();

    _future = PostionService().getpositionStockB();
  }

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(textScaleFactor: mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(text: "เพิ่มรถยนต์ใหม่", style: TextStyleMenuName.bodyMenuThai, children: <TextSpan>[
                TextSpan(text: '\nAdd New Car', style: TextStyleMenuName.bodyMenuEng),
              ])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MenuPage()));
              });
            },
            icon: const Icon(
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
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    SizedBox(
                        height: 700,
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
                                  child: SingleChildScrollView(
                                      child: Column(children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child:
                                                  Text(textScaleFactor: 1, 'เลขตัวถัง', style: TextStyleAdd.bodyAdd14),
                                            ),
                                          ),
                                          // <----------------- เลขตัวถัง ----------------->
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: SizedBox(
                                                    height: 35.2,
                                                    child: MediaQuery(
                                                      data: mqDataNew,
                                                      child: TextFormField(
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(17),
                                                        ],
                                                        controller: ChassisController,
                                                        style: TextStyleAlert.body15bold,
                                                        decoration: InputDecoration(
                                                          contentPadding: const EdgeInsets.symmetric(
                                                              vertical: 25.0, horizontal: 10),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5.5),
                                                          ),
                                                          enabledBorder: const OutlineInputBorder(
                                                            borderSide: const BorderSide(
                                                                color: const Color(0xffE2E8F0), width: 1),
                                                          ),
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                InkWell(
                                                    child: SizedBox(
                                                        height: 40,
                                                        width: 40,
                                                        child: Card(
                                                          semanticContainer: true,
                                                          shape: const BeveledRectangleBorder(
                                                            side: BorderSide(
                                                              color: Color(0xffE2E8F0),
                                                              width: 0.1,
                                                            ),
                                                          ),
                                                          child: IconButton(
                                                            icon: Image.asset(
                                                              'assets/images/iconscan.png',
                                                              height: 18.94,
                                                              width: 18.94,
                                                            ),
                                                            onPressed: () => scanBarcode(),
                                                          ),
                                                        )))
                                              ],
                                            ),
                                          ),
                                          // <----------------- สถานี ----------------->
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'สถานี',
                                                style: TextStyleAdd.bodyAdd14,
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  border: new Border.all(
                                                    color: const Color(0xffE2E8F0),
                                                  ),
                                                  borderRadius: BorderRadius.circular(5.5)),
                                              child: Container(
                                                height: 35.2,
                                                child: Padding(
                                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                                    child: DropdownButton(
                                                      hint: const Text(
                                                        'กรุณาเลือกสถานี',
                                                        style: TextStyle(
                                                          fontFamily: ('Bai Jamjuree'),
                                                        ),
                                                        textScaleFactor: 1,
                                                      ),
                                                      elevation: 10,
                                                      icon: const Icon(Icons.arrow_drop_down),
                                                      iconSize: 13.0,
                                                      isExpanded: true,
                                                      style: const TextStyle(color: Color(0xff757575), fontSize: 14.0),
                                                      items: where_data?.map((item) {
                                                        return DropdownMenuItem(
                                                          value: item['where_id'].toString(),
                                                          child: new Text(
                                                            item['car_where'],
                                                            style: TextStyle(
                                                              fontFamily: ('Bai Jamjuree'),
                                                            ),
                                                            textScaleFactor: 1,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (String? newVal) {
                                                        setState(() {
                                                          Whereid = newVal;

                                                          WhereController.text = Whereid.toString();

                                                          selected = '';
                                                          line = '';
                                                          sort = '';

                                                          print(Whereid);
                                                        });
                                                      },
                                                      value: Whereid,
                                                    )),
                                              ),
                                            ),
                                          ),
                                          // <----------------- ตำแหน่ง ----------------->
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'ตำแหน่ง',
                                                style: TextStyleAdd.bodyAdd14,
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                          ),
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
                                                            if (Whereid == '1') {
                                                              return StockA();
                                                            } else if (Whereid == '2') {
                                                              return StockB();
                                                            } else if (Whereid == '3') {
                                                              return StockC();
                                                            } else if (Whereid == '4') {
                                                              return StockD();
                                                            }
                                                            /*  return Align(
                                                                    alignment: Alignment.topCenter,
                                                                   ); */
                                                          }
                                                          return const Center(
                                                              child: Text(
                                                            'กรุณาเลือกสถานี',
                                                            style: TextStyle(
                                                              fontFamily: ('Bai Jamjuree'),
                                                            ),
                                                            textScaleFactor: 1,
                                                          ));
                                                        }))
                                              ]),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
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
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Container(
                                                        height: 85,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(12),
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                                                blurRadius: 10,
                                                              ),
                                                            ]),
                                                        child: Column(
                                                          children: <Widget>[
                                                            const Padding(
                                                              padding: EdgeInsets.only(top: 2),
                                                              child: Text(
                                                                'แถว',
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(0xffD4D4D4),
                                                                  fontFamily: ('Bai Jamjuree'),
                                                                ),
                                                                textScaleFactor: 1,
                                                              ),
                                                            ),
                                                            Text(
                                                              line!,
                                                              style: const TextStyle(
                                                                color: Color(0xff404040),
                                                                fontFamily: ('Kanit'),
                                                                fontSize: 36,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                              textScaleFactor: 1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 87,
                                                      width: double.infinity,
                                                      child: Container(
                                                        height: 85,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(12),
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                                                blurRadius: 10,
                                                              ),
                                                            ]),
                                                        child: Column(
                                                          children: <Widget>[
                                                            const Padding(
                                                              padding: EdgeInsets.only(top: 2),
                                                              child: Text(
                                                                'ลำดับ',
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(0xffD4D4D4),
                                                                  fontFamily: ('Bai Jamjuree'),
                                                                ),
                                                                textScaleFactor: 1,
                                                              ),
                                                            ),
                                                            Text(
                                                              selected!,
                                                              style: const TextStyle(
                                                                fontSize: 36,
                                                                color: Color(0xff404040),
                                                                fontFamily: ('Kanit'),
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                              textScaleFactor: 1,
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
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Center(
                                      child: SizedBox(
                                        height: 36.55,
                                        width: 280,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: const Color(0xffE52628),
                                              minimumSize: const Size.fromHeight(40),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                          onPressed: () => _AddCar(context),
                                          child: AutoSizeText(
                                            'บันทึก',
                                            style: TextStyleBtn.bodybtn,
                                            maxFontSize: 12,
                                            minFontSize: 11,
                                          ),
                                        ),
                                      ),
                                    )
                                  ])))),
                        )),
                    const SizedBox(height: 10),
                    Text('Powered by Weise Technika', style: TextStyleFoot.bodyfoot, textScaleFactor: 1.0),
                  ]))),
        ])));
  }

  //<-----------------------------------------------  Method Function ----------------------------------------------------->
  _AddCar(context) {
    bool isLoading = false;
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
            "คุณต้องการทำรายการเพิ่มรถยนต์",
            style: TextStyleAlert.body15normal,
            textScaleFactor: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ChassisController.text,
                style: TextStyleAlert.body15bold,
                textScaleFactor: 1,
              ),
              const SizedBox(width: 5),
              Text(
                "ใช่หรือไม่",
                style: TextStyleAlert.body15normal,
                textScaleFactor: 1,
              )
            ],
          ),
        ]),
      ),
      buttons: [
        DialogButton(
          /* onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddnewSplash()));
          }, */
          color: const Color(0xff44A73B),
          child: Text("ยืนยัน", style: TDialogButton.body14),
          onPressed: () async {
            //CircularProgressIndicator()
            //_fetchData(context);

            setState(() {
              _fetchData(context);
            });
            ResponseModel respones = await PostcarDB().CarDB(
              ChassisController.text,
              PositController.text,
              "1",
              "${userData['id']}",
              DateFormat("yyyy-MM-dd").format(DateTime.now()),
              DateFormat.Hm().format(DateTime.now()),
              1.toString(),
              WhereController.text,
            );
            if (respones.success) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddnewSplash()));
            } else {
              _ErrorAddcar(context);
            }

            /* ResponseModel respones = await PostcarDB().CarDB(
              ChassisController.text,
              PositController.text,
              "1",
              "${userData['id']}",
              DateFormat("yyyy-MM-dd").format(DateTime.now()),
              DateFormat.Hm().format(DateTime.now()),
              1.toString(),
              WhereController.text,
            ); */

            /* if (respones.success) {
              
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AddnewSplash()));
            } else {
              _ErrorAddcar(context);
            } */
          },
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color(0xffE52628),
          child: Text("ยกเลิก", style: TDialogButton.body14),
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

  _ErrorAddcar(context) {
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
      image: Image.asset('assets/images/iconalert.png'),
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "แจ้งเตือน ",
            style: TextStyleAlert.body18bold,
            textScaleFactor: 1,
          ),
          const SizedBox(height: 5),
          Text(
            "เพิ่มรถยนต์ไม่สำเร็จ",
            style: TextStyleAlert.body15normal,
            textScaleFactor: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              Text(
                "กรุณาลองใหม่อีกครั้ง",
                style: TextStyleAlert.body15normal,
                textScaleFactor: 1,
              )
            ],
          ),
        ]),
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddnewcarPage()));
          },
          color: const Color(0xff44A73B),
          child: Text("ตกลง", style: TDialogButton.body14),
        ),
      ],
    ).show();
  }

  /*  Widget Stock() {
    return FutureBuilder(
        future: PostionService().getWhere1(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PositDBAPI>?> snapshot) {
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

                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();
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
        });
  }
 */
  //////////////// Stock A //////////////////
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
}
