// ignore_for_file: unnecessary_new

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
import 'package:vdqims/Service/API/PostCarApi.dart';
import 'package:vdqims/Service/Model/PositionModel.dart';
import 'package:vdqims/Service/Model/ReqDBModel.dart';
import 'package:vdqims/SplashScreen/MainSplash1.dart';
import 'package:vdqims/Style/TextStyle.dart';
import 'package:http/http.dart' as http;
import '../../Service/Model/PositDBModel.dart';
import '../../SplashScreen/AddnewSplash.dart';
import '../FindcarPage/Model/FindcarModel.dart';
import '../FindcarPage/Model/responsModel.dart';
import '../MenuPage/MenuPage.dart';

class AddnewcarPage extends StatefulWidget {
  const AddnewcarPage({Key? key}) : super(key: key);

  @override
  State<AddnewcarPage> createState() => _AddnewcarPageState();
}

class _AddnewcarPageState extends State<AddnewcarPage> {
  late Future<List<PositionAPI>> _future;

  // <------------------------ updateposition ------------------------>
  dynamic urlup = 'http://206.189.92.79/api/';
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
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
      };
      if (_authToken != null) {
        urlup = Uri.parse("http://206.189.92.79/api/posit/$IDposit");
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

  var url = Uri.encodeFull('http://206.189.92.79/api/where/s/0');
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
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

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
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 5),
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
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SingleChildScrollView(
                                            child: Column(children: <Widget>[
                                          Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        textScaleFactor: 1,
                                                        'เลขตัวถัง',
                                                        style: TextStyleAdd
                                                            .bodyAdd14),
                                                  ),
                                                ),
                                                // <----------------- เลขตัวถัง ----------------->
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                            child:
                                                                TextFormField(
                                                              controller: ChassisController =
                                                                  TextEditingController(
                                                                      text:
                                                                          "$qrCode"),
                                                              style:
                                                                  TextStyleAlert
                                                                      .body15bold,
                                                              readOnly: true,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            25.0,
                                                                        horizontal:
                                                                            10),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.5),
                                                                ),
                                                                enabledBorder:
                                                                    const OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color: const Color(
                                                                          0xffE2E8F0),
                                                                      width: 1),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
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
                                                                semanticContainer:
                                                                    true,
                                                                shape:
                                                                    const BeveledRectangleBorder(
                                                                  side:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xffE2E8F0),
                                                                    width: 0.1,
                                                                  ),
                                                                ),
                                                                child:
                                                                    IconButton(
                                                                  icon: Image
                                                                      .asset(
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'สถานี',
                                                      style: TextStyleAdd
                                                          .bodyAdd14,
                                                      textScaleFactor: 1,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        border: new Border.all(
                                                          color: const Color(
                                                              0xffE2E8F0),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.5)),
                                                    child: Container(
                                                      height: 35.2,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: DropdownButton(
                                                            hint: const Text(
                                                              'VDQI station',
                                                              textScaleFactor:
                                                                  1,
                                                            ),
                                                            elevation: 10,
                                                            icon: const Icon(Icons
                                                                .arrow_drop_down),
                                                            iconSize: 13.0,
                                                            isExpanded: true,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff757575),
                                                                fontSize: 14.0),
                                                            items: where_data
                                                                ?.map((item) {
                                                              return DropdownMenuItem(
                                                                value: item[
                                                                        'where_id']
                                                                    .toString(),
                                                                child: new Text(
                                                                  item[
                                                                      'car_where'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        ('Bai Jamjuree'),
                                                                  ),
                                                                  textScaleFactor:
                                                                      1,
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newVal) {
                                                              setState(() {
                                                                Whereid =
                                                                    newVal;

                                                                WhereController
                                                                        .text =
                                                                    Whereid
                                                                        .toString();

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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'ตำแหน่ง',
                                                      style: TextStyleAdd
                                                          .bodyAdd14,
                                                      textScaleFactor: 1,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xffE2E8F0))),
                                                    height: 350,
                                                    child: Column(children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 25),
                                                      ),
                                                      Expanded(
                                                          child: FutureBuilder(
                                                              future: _future,
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          List<
                                                                              PositionAPI>?>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<PositionAPI>?
                                                                      data =
                                                                      snapshot
                                                                          .data;
                                                                  if (Whereid ==
                                                                      '1') {
                                                                    return StockA();
                                                                  } else if (Whereid ==
                                                                      '2') {
                                                                    return StockB();
                                                                  } else if (Whereid ==
                                                                      '3') {
                                                                    return StockC();
                                                                  } else if (Whereid ==
                                                                      '4') {
                                                                    return StockD();
                                                                  }
                                                                  /*  return Align(
                                                                      alignment: Alignment.topCenter,
                                                                     ); */
                                                                }
                                                                return const Center(
                                                                    child: Text(
                                                                  'กรุณาเลือกสถานี',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        ('Bai Jamjuree'),
                                                                  ),
                                                                  textScaleFactor:
                                                                      1,
                                                                ));
                                                              }))
                                                    ]),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color:
                                                              Color(0xffF6F6F6),
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
                                                            width:
                                                                double.infinity,
                                                            child: Card(
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                2),
                                                                    child: Text(
                                                                      'แถว',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xffD4D4D4),
                                                                        fontFamily:
                                                                            ('Bai Jamjuree'),
                                                                      ),
                                                                      textScaleFactor:
                                                                          1,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    line!,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xff404040),
                                                                      fontFamily:
                                                                          ('Kanit'),
                                                                      fontSize:
                                                                          36,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    textScaleFactor:
                                                                        1,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: SizedBox(
                                                              height: 87,
                                                              width: double
                                                                  .infinity,
                                                              child: Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    const Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 2),
                                                                      child:
                                                                          Text(
                                                                        'ลำดับ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(0xffD4D4D4),
                                                                          fontFamily:
                                                                              ('Bai Jamjuree'),
                                                                        ),
                                                                        textScaleFactor:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      selected!,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            36,
                                                                        color: Color(
                                                                            0xff404040),
                                                                        fontFamily:
                                                                            ('Kanit'),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      textScaleFactor:
                                                                          1,
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
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25.0),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color(0xffE52628),
                                                    minimumSize: const Size
                                                        .fromHeight(40),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () =>
                                                    _AddCar(context),
                                                child: AutoSizeText(
                                                  'บันทึก',
                                                  style: TextStyleBtn.bodybtn,
                                                  maxFontSize: 12,
                                                  minFontSize: 11,
                                                ),
                                              ))
                                        ])))))),
                        const SizedBox(height: 10),
                        Text('Powered by Weise Technika',
                            style: TextStyleFoot.bodyfoot,
                            textScaleFactor: 1.0),
                      ]))),
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
            ResponseModel respones = await PostCarAPI().PostCar(
                ChassisController.text,
                "1",
                WhereController.text,
                PositController.text,
                "${userData['fullname']}",
                "${userData['lastname']}",
                DateFormat("yyyy-MM-dd").format(DateTime.now()),
                DateFormat("hh:mm:ss a").format(DateTime.now()),
                lineController.text);

            if (respones.success) {
              getcar();

              /* 
                FutureBuilder(
                  future: getcar(),
                  builder: (BuildContext context,AsyncSnapshot<List<CarAPI>?> snapshot){
                    
                      List<CarAPI>? data = snapshot.data;
                      print(snapshot.data);
                      print(data);
                      print('data');
                      
                     
                     
                    
                    return Text('Error');
                  }
                  
                  

                  
                  
                 );
              */

              /* String Car = respones as String ;
               SharedPreferences localStorage =await SharedPreferences.getInstance();
               localStorage.setString('Car', Car);   */

              /* ResponseModel responesPut = await PutPosition(
                "1",
                "",

              ); */
              /*  if (responesPut.success) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddnewSplash()));
              } */
            } else {
              _ErrorAddcar(context);
            }
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

  getcar() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');
    var response = await http.get(
        Uri.parse('http://206.189.92.79/api/car/id/${ChassisController.text}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
        });
    dynamic car = jsonDecode(response.body);

    /* return car; */
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    localStorage1.setString('car', json.encode(car));

    var IdData;
    SharedPreferences localStorage2 = await SharedPreferences.getInstance();
    var carJson = localStorage2.getString('car');
    var cars = json.decode(carJson!);
    setState(() {
      IdData = cars;
    });

    var AA = (IdData[0]['car_id']);
    print(AA);
    ResponseModel responesPut = await PutPosition(
      "1",
      "$AA", /* IdData[0]['car_id'] */
    );
    if (responesPut.success){
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddnewSplash()));
                   

    }

    /*  var carData;
        var carJson = localStorage.getString('car');
        var car1 = json.decode(carJson!);
        setState(() {
        carData = car1;
      }); */

    /*  print(car); */

    /* ResponseModel responesPut = await PutPosition(
                    "${carData['car_line']}", /* "${carData['car_line']}" */);  */

    /* print('${carData['car_id']}'); */
  }
  /*  Future<List<CarAPI>> getcar() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');
    var response = await http.get(
        Uri.parse(
            'http://206.189.92.79/api/car/search/${ChassisController.text}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
        });
        
        if(response.car_statusCode == 200){
          var car = Car.fromJson(jsonDecode(response.body));
          return car.data;
          print(response.body);

        }else{
          print('error');
        }

  } */

  /* Future<List<CarAPI>> getcar() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(
        Uri.parse(
            'http://206.189.92.79/api/car/search/${ChassisController.text}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
        });
    // return value
    dynamic car = Car.fromJson(jsonDecode(response.body));

    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    localStorage.setString('car', car);

    return car.data;
    
    
     //localStorage.setString('car', car); 
    
  } */

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
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddnewcarPage()));
          },
          color: const Color(0xff44A73B),
          child: Text("ตกลง", style: TDialogButton.body14),
        ),
      ],
    ).show();
  }

  //////////////// Stock A //////////////////
  Widget StockA() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
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
                              child: Text(
                                'Lotus',
                                textScaleFactor: 1,
                              ),
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
                          future: PostionService().getWhere1(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                            if (snapshot.hasData) {
                              List<PositDBAPI>? data = snapshot.data;
                              return Container(
                                child: GridView.builder(
                                    padding: const EdgeInsets.all(2),
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
                                          color: (data[index].car_status == 1
                                              ? Colors.red
                                              : data[index].car_status == 2
                                                  ? Colors.grey
                                                  : sort ==
                                                          data[index]
                                                              .sort
                                                              .toString()
                                                      ? Colors.red
                                                      : const Color(
                                                          0xff89EB80)),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            dynamic Idposit =
                                                data[index].posit_id.toString();

                                            SharedPreferences localStorage =
                                                await SharedPreferences
                                                    .getInstance();
                                            localStorage.setString(
                                                'ID', Idposit);

                                            setState(() {
                                              if (data[index].car_status == 1) {
                                                selected = '';
                                                line = '';
                                                sort = '';
                                              } else if (data[index].car_status ==
                                                  2) {
                                                selected = '';
                                                line = '';
                                                sort = '';
                                              } else {
                                                selected = data[index]
                                                    .posit
                                                    .toString();
                                                line =
                                                    data[index].line.toString();
                                                sort =
                                                    data[index].sort.toString();

                                                PositController.text =
                                                    selected.toString();
                                                lineController.text =
                                                    line.toString();

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
                                              style: TextStyle(
                                                  color: Colors.white),
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
        ),
      ),
    );
  }

  Widget StockB() {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: Container(
        child: Column(
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
                              child: Text(
                                'Lotus',
                                textScaleFactor: 1,
                              ),
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
                          future: PostionService().getWhere2(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                            if (snapshot.hasData) {
                              List<PositDBAPI>? data = snapshot.data;
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
                                          color: (data[index].car_status == 1
                                              ? Colors.red
                                              : data[index].car_status == 2
                                                  ? Colors.grey
                                                  : sort ==
                                                          data[index]
                                                              .sort
                                                              .toString()
                                                      ? Colors.red
                                                      : const Color(
                                                          0xff89EB80)),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            dynamic Idposit =
                                                data[index].posit_id.toString();

                                            SharedPreferences localStorage =
                                                await SharedPreferences
                                                    .getInstance();
                                            localStorage.setString(
                                                'ID', Idposit);

                                            setState(() {
                                              if (data[index].car_status == 1) {
                                                selected = '';
                                                line = '';
                                                sort = '';
                                              } else if (data[index].car_status ==
                                                  2) {
                                                selected = '';
                                                line = '';
                                                sort = '';
                                              } else {
                                                selected = data[index]
                                                    .posit
                                                    .toString();
                                                line =
                                                    data[index].line.toString();
                                                sort =
                                                    data[index].sort.toString();

                                                PositController.text =
                                                    selected.toString();
                                                lineController.text =
                                                    line.toString();

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
                                              style: TextStyle(
                                                  color: Colors.white),
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
        ),
      ),
    );
  }

  Widget StockC() {
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
                          child: Text(
                            'Lotus',
                            textScaleFactor: 1,
                          ),
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
                      future: PostionService().getWhere3(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                        if (snapshot.hasData) {
                          List<PositDBAPI>? data = snapshot.data;
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
                                      color: (data[index].car_status == 1
                                          ? Colors.red
                                          : data[index].car_status == 2
                                              ? Colors.grey
                                              : sort ==
                                                      data[index]
                                                          .sort
                                                          .toString()
                                                  ? Colors.red
                                                  : const Color(0xff89EB80)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        dynamic Idposit =
                                            data[index].posit_id.toString();

                                        SharedPreferences localStorage =
                                            await SharedPreferences
                                                .getInstance();
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
                                            selected =
                                                data[index].posit.toString();
                                            line = data[index].line.toString();
                                            sort = data[index].sort.toString();

                                            PositController.text =
                                                selected.toString();
                                            lineController.text =
                                                line.toString();

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
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget StockD() {
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
                          child: Text(
                            'Lotus',
                            textScaleFactor: 1,
                          ),
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
                      future: PostionService().getWhere4(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PositDBAPI>?> snapshot) {
                        if (snapshot.hasData) {
                          List<PositDBAPI>? data = snapshot.data;
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
                                      color: (data[index].car_status == 1
                                          ? Colors.red
                                          : data[index].car_status == 2
                                              ? Colors.grey
                                              : sort ==
                                                      data[index]
                                                          .sort
                                                          .toString()
                                                  ? Colors.red
                                                  : const Color(0xff89EB80)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        dynamic Idposit =
                                            data[index].posit_id.toString();

                                        SharedPreferences localStorage =
                                            await SharedPreferences
                                                .getInstance();
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
                                            selected =
                                                data[index].posit.toString();
                                            line = data[index].line.toString();
                                            sort = data[index].sort.toString();

                                            PositController.text =
                                                selected.toString();
                                            lineController.text =
                                                line.toString();

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
              )
            ],
          ),
        ))
      ],
    );
  }
}
