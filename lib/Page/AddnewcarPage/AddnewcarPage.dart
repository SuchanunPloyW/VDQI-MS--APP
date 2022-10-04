// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vdqims/Service/API/PositionAPI.dart';
import 'package:vdqims/Service/Model/PositionModel.dart';
import 'package:vdqims/SplashScreen/AddnewSplash.dart';
import 'package:vdqims/Style/TextStyle.dart';
import 'package:http/http.dart' as http;
import '../MenuPage/MenuPage.dart';

class AddnewcarPage extends StatefulWidget {
  const AddnewcarPage({Key? key}) : super(key: key);

  @override
  State<AddnewcarPage> createState() => _AddnewcarPageState();
}

class _AddnewcarPageState extends State<AddnewcarPage> {
  late Future<List<PositionAPI>> _future;
  // <------------------------ ตัวแปร ------------------------>
  String? selected = "";
  List? where_data;
  String? Whereid;
  String? Groupvalue;
  String? _radioValue = '';
  String qrCode = '';
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);

// <------------------------ Service ------------------------>
  var url = Uri.encodeFull('http://206.189.92.79/api/where');
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
  TextEditingController GroupController = TextEditingController();
  TextEditingController WhereController = TextEditingController();
  // <------------------------ Function ------------------------>

  @override
  void initState() {
    super.initState();
    this.where();
    _future = PostionService().getpositionStockB();
  }

  void _handleRadioValueChange(value) {
    setState(() {
      print(value);
      _radioValue = value;
      GroupController.text = _radioValue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mqHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "เพิ่มรถยนต์ใหม่",
                  style: TextStyleMenuName.bodyMenuThai,
                  children: <TextSpan>[
                    TextSpan(
                        text: '\nAdd New Car',
                        style: TextStyleMenuName.bodyMenuEng),
                  ])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MenuPage()));
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
              onPressed: () {},
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
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height: 700,
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
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: SingleChildScrollView(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'เลขตัวถัง',
                                                                style: TextStyleAdd
                                                                    .bodyAdd14),
                                                          ),
                                                        ),
                                                        // <----------------- เลขตัวถัง ----------------->
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 10,
                                                            right: 10,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                child: SizedBox(
                                                                  height: 35.2,
                                                                  child:
                                                                      TextField(
                                                                    controller: ChassisController =
                                                                        TextEditingController(
                                                                            text:
                                                                                "$qrCode"),
                                                                    style: TextStyleAlert
                                                                        .body15bold,
                                                                    readOnly:
                                                                        true,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      contentPadding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              25.0,
                                                                          horizontal:
                                                                              10),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.5),
                                                                      ),
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color:
                                                                                const Color(0xffE2E8F0),
                                                                            width: 1),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              InkWell(
                                                                  child: SizedBox(
                                                                      height: 40,
                                                                      width: 40,
                                                                      child: Card(
                                                                        semanticContainer:
                                                                            true,
                                                                        shape:
                                                                            const BeveledRectangleBorder(
                                                                          side:
                                                                              BorderSide(
                                                                            color:
                                                                                Color(0xffE2E8F0),
                                                                            width:
                                                                                0.1,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            IconButton(
                                                                          icon:
                                                                              Image.asset(
                                                                            'assets/images/iconscan.png',
                                                                            height:
                                                                                18.94,
                                                                            width:
                                                                                18.94,
                                                                          ),
                                                                          onPressed: () =>
                                                                              scanQRCode(),
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text('สถานี',
                                                                style: TextStyleAdd
                                                                    .bodyAdd14),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: DecoratedBox(
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        new Border
                                                                            .all(
                                                                      color: const Color(
                                                                          0xffE2E8F0),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.5)),
                                                            child: Container(
                                                              height: 35.2,
                                                              child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                                  child:
                                                                      DropdownButton(
                                                                    hint: const Text(
                                                                        'VDQI station'),
                                                                    elevation:
                                                                        10,
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .arrow_drop_down),
                                                                    iconSize:
                                                                        13.0,
                                                                    isExpanded:
                                                                        true,
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xff757575),
                                                                        fontSize:
                                                                            14.0),
                                                                    items: where_data
                                                                        ?.map(
                                                                            (item) {
                                                                      return DropdownMenuItem(
                                                                        value: item['where_id']
                                                                            .toString(),
                                                                        child: new Text(
                                                                            item['car_where']),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (String?
                                                                            newVal) {
                                                                      setState(
                                                                          () {
                                                                        Whereid =
                                                                            newVal;

                                                                        print(
                                                                            Whereid);
                                                                      });
                                                                    },
                                                                    value:
                                                                        Whereid,
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                        // <----------------- ตำแหน่ง ----------------->
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'ตำแหน่ง',
                                                                style: TextStyleAdd
                                                                    .bodyAdd14),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: const Color(
                                                                        0xffE2E8F0))),
                                                            height: 350,
                                                            child: Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            25),
                                                                  ),
                                                                  Expanded(
                                                                      child: FutureBuilder(
                                                                          future: _future,
                                                                          builder: (BuildContext context, AsyncSnapshot<List<PositionAPI>?> snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              List<PositionAPI>? data = snapshot.data;
                                                                              if (Whereid == '1') {
                                                                                return StockA();
                                                                              } else if (Whereid == '2') {
                                                                                return StockB();
                                                                              }
                                                                              /*  return Align(
                                                                          alignment: Alignment.topCenter,
                                                                         ); */
                                                                            }
                                                                            return const Center(child: Text('กรุณาเลือกสถานี'));
                                                                          }))
                                                                ]),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),

                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              boxShadow: <
                                                                  BoxShadow>[
                                                                BoxShadow(
                                                                  color: Color(
                                                                      0xffF6F6F6),
                                                                  blurRadius:
                                                                      20,
                                                                  offset:
                                                                      Offset(
                                                                          5, 5),
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
                                                                  child:
                                                                      SizedBox(
                                                                    height: 87,
                                                                    width: double
                                                                        .infinity,
                                                                    child: Card(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                      child:
                                                                          Column(
                                                                        children: const <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 1),
                                                                            child:
                                                                                Text(
                                                                              'แถว',
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Color(0xffD4D4D4),
                                                                                fontFamily: ('IBM Plex Sans Thai'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 1),
                                                                            child:
                                                                                Text(
                                                                              'A',
                                                                              style: TextStyle(
                                                                                fontSize: 25,
                                                                                color: Color(0xff404040),
                                                                                fontFamily: ('IBM Plex Sans Thai'),
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    height: 87,
                                                                    width: double
                                                                        .infinity,
                                                                    child: Card(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 1),
                                                                            child:
                                                                                Text(
                                                                              'ลำดับ',
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Color(0xffD4D4D4),
                                                                                fontFamily: ('IBM Plex Sans Thai'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 1),
                                                                            child:
                                                                                Text(
                                                                              selected!,
                                                                              style: const TextStyle(
                                                                                fontSize: 25,
                                                                                color: Color(0xff404040),
                                                                                fontFamily: ('IBM Plex Sans Thai'),
                                                                                fontWeight: FontWeight.bold,
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
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 25.0),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            primary:
                                                                const Color(
                                                                    0xffE52628),
                                                            minimumSize: const Size
                                                                .fromHeight(40),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                        onPressed: () =>
                                                            _AddCar(context),
                                                        child: const Text(
                                                            'บันทึก',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  ('IBM Plex Sans Thai'),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ))
                                                ])))))),
                            const SizedBox(height: 10),
                            Text('Powered by Weise Technika',
                                style: TextStyleFoot.bodyfoot),
                          ])))),
        ])));
  }

  //<-----------------------------------------------  Method Function ----------------------------------------------------->
  _AddCar(context) {
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
          Text("ต้องการทำรายการ ?", style: TextStyleAlert.body18bold),
          const SizedBox(height: 5),
          Text("คุณต้องการทำรายการเพิ่มรถยนต์",
              style: TextStyleAlert.body15normal),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ChassisController.text, style: TextStyleAlert.body15bold),
              const SizedBox(width: 5),
              Text("ใช่หรือไม่", style: TextStyleAlert.body15normal)
            ],
          ),
        ]),
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddnewSplash()));
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
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }

  //////////////// Stock A //////////////////
  Widget StockA() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  color: Colors.white,
                  height: 30,
                  width: 50,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("A",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("B",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("C",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        "D",
                        style: TextStyle(
                          fontSize: 18,
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
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Container(
                width: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    Container(
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                          ),
                          color: const Color.fromARGB(246, 231, 230, 236),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text('Lotus'),
                        ))
                  ]),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                      future: PostionService().getpositionStockA(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PositionAPI>?> snapshot) {
                        if (snapshot.hasData) {
                          List<PositionAPI>? data = snapshot.data;
                          return Container(
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
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                      color: (data[index].position_status == '1'
                                          ? Colors.red
                                          : data[index].position_status == '2'
                                              ? Colors.grey
                                              : selected ==
                                                      data[index].car_position
                                                  ? Colors.red
                                                  : const Color(0xff89EB80)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected = data[index]
                                              .car_position
                                              .toString();
                                          print(data[index].car_position);
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          data[index].car_position,
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
              )
            ],
          ),
        ))
      ],
    );
  }
  //////////////// Stock B //////////////////

  Widget StockB() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  color: Colors.white,
                  height: 30,
                  width: 50,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("A",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("B",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("C",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        "D",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "E",
                        style: TextStyle(
                          fontSize: 18,
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
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Container(
                width: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    Container(
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                          ),
                          color: const Color.fromARGB(246, 231, 230, 236),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text('Lotus'),
                        ))
                  ]),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                      future: PostionService().getpositionStockB(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PositionAPI>?> snapshot) {
                        if (snapshot.hasData) {
                          List<PositionAPI>? data = snapshot.data;
                          return Container(
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
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                      color: (data[index].position_status == '1'
                                          ? Colors.red
                                          : data[index].position_status == '2'
                                              ? Colors.grey
                                              : selected ==
                                                      data[index].car_position
                                                  ? Colors.red
                                                  : const Color(0xff89EB80)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected = data[index]
                                              .car_position
                                              .toString();
                                          print(data[index].car_position);
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          data[index].car_position,
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
              )
            ],
          ),
        ))
      ],
    );
  }
}
