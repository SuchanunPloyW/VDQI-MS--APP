import 'dart:convert';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';

import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import 'package:http/http.dart' as http;
import '../../Style/TextStyle.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({Key? key, required this.model}) : super(key: key);
  final String model;

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  
  List ? station_data ;
  String? Staid;

var url = Uri.encodeFull('http://206.189.92.79/api/station');
Future<String> station() async {
SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');
    var res = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $_authToken',
    }); 
    var resBody = json.decode(res.body);
     print(resBody);
     setState(() {
      station_data = resBody;
    });
    return "Sucess";
}

/* Future<List<StationAPI>> getstation() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');
     
   
    // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/station'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    var car_station = Station.fromJson(jsonDecode(response.body));
    setState(() {
      Sta = car_station as List;
    });
    
    // return value
    return car_station.data;
  }
 */
  

  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  void initState() {
    super.initState();
    this.station();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      // BG Red //
          Padding(
              padding: EdgeInsets.only(top: 5),
              child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //////////////// /* Card white */   ////////////////
                            SizedBox(
                                height: 650,
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
                                              child: Column(children: <Widget>[
                                                //////////////// /* Card เลขตัวถัง */   ////////////////
                                                Padding(
                                                  padding: const EdgeInsets.only(
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
                                                    height: 85.0,
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: ListTile(
                                                        title: Text(
                                                          widget.model,
                                                          style: const TextStyle(
                                                            fontFamily:
                                                                ('IBM Plex Sans Thai'),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
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
                                                        subtitle: const Text(
                                                          ' Yaris Ativ 1.2 G ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                ('IBM Plex Sans Thai'),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //////////////// /* Card เลขตัวถัง */   ////////////////
                                                const SizedBox(height: 25),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'ข้อมูลการเช็คอิน',
                                                        style: TextStyleCheckin
                                                            .bodyCheckin20,
                                                      )),
                                                ),
                                                const SizedBox(height: 8),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'สถานี',
                                                        style: TextStyleCheckin
                                                            .bodyCheckin14,
                                                      )),
                                                ),
                                                 Padding(
                                                   padding:EdgeInsets.only( left: 15,right:15),
                                                   child: DecoratedBox(
                                                     decoration:BoxDecoration(
                                                      border:  Border.all(
                                                        color:const Color(0xffE2E8F0),
                                                      ),
                                                       borderRadius:BorderRadius.circular(5.5)),
                                                        child: Container(
                                                          height: 35.2,
                                                          child: Padding(
                                                             padding: EdgeInsets.only(left:10, right:10),
                                                           child:DropdownButton(
                                                            hint: const Text('VDQI station'),
                                                            elevation:10,
                                                             icon: const Icon( Icons.arrow_drop_down),
                                                             iconSize:13.0,
                                                             isExpanded:true,
                                                             style: const TextStyle(color: Color(0xff757575),fontSize:14.0),
                                                             items: station_data?.map((item){
                                                              return DropdownMenuItem(
                                                                child: new Text(item['car_station']),
                                                                value: item['car_station'].toString(),
                                                              );
                                                             }).toList(),
                                                              onChanged: (String? newVal) { 
                                                                setState(() {
                                                                  Staid = newVal;
                                                                  print(Staid.toString());
                                                                });
                                                               },
                                                               value: Staid,
                                                                           
                                                           )                   
                                                                               
                                                          ) ,

                                                        )
                                                                              
                                                     
                                                   )
                                                ),


                                       /*          Center(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                0.0),
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 19.0,
                                                                    right: 19.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              /* border: Border.all(color: Color(0xff757575), width: 1.0), */
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                            ),
                                                            child:DecoratedBox(
                                                               decoration:  BoxDecoration(
                                                                 border: new Border.all(
                                                                   color:const Color(0xffE2E8F0),
                                                                 ),
                                                                 borderRadius:BorderRadius.circular(5.5)),
                                                                 child:Container(
                                                                   height: 35.2,
                                                                   child: Padding(
                                                                    padding: EdgeInsets.only(left:10, right:10 ),
                                                                 
                                                                    child: DropdownButton(
                                                            
                                                              items: station_data?.map((item){
                                                              return DropdownMenuItem(
                                                                child: new Text(item['car_station']),
                                                                value: item['car_station'].toString(),
                                                              );
                                                              }).toList(), 
                                                              onChanged: (String? newVal) { 
                                                                setState(() {
                                                                  Staid = newVal;
                                                                  print(Staid.toString());
                                                                });
                                                               },
                                                               value: Staid,
                                                            ),
                                                                   
                                                                              
                                                                   )
                                                                        
                                                                 )      
                                                                           
                                                               
                                                            )
                                                                    








                                                            )
                                                            )
                                                            ), */
                                                const SizedBox(height: 330),
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 25.0),
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
                                                          _request(context),
                                                      child: const Text(
                                                          'เช็คอินเข้าสถานี',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                ('IBM Plex Sans Thai'),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ))
                                              ]),
                                            ))))),
                            const SizedBox(height: 10),
                            Text('Powered by Weise Technika',
                                style: TextStyleFoot.bodyfoot),
                          ]))))
        ])));
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
          Text("ต้องการทำรายการ ?", style: TextStyleAlert.body18bold),
          SizedBox(height: 5),
          Text("คุณต้องการทำรายการเช็คอิน", style: TextStyleAlert.body15normal),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.model, style: TextStyleAlert.body15bold),
              SizedBox(width: 5),
              Text("เข้าสถานี", style: TextStyleAlert.body15normal)
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("VDQI Station", style: TextStyleAlert.body15bold),
                  SizedBox(width: 5),
                  Text("ใช่หรือไม่", style: TextStyleAlert.body15normal)
                ],
              )
            ],
          ),
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
          onPressed: () {
             Navigator.push(
                  context, MaterialPageRoute(
                    builder: (_) => SplashScreen()));
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
  // < ------------------      Alert        ------------------>

}
class SplashScreen extends StatelessWidget {
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

