import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Style/TextStyle.dart';
import 'package:http/http.dart' as http;
import '../MenuPage/MenuPage.dart';

class AddnewcarPage extends StatefulWidget {
  const AddnewcarPage({Key? key}) : super(key: key);

  @override
  State<AddnewcarPage> createState() => _AddnewcarPageState();
}

class _AddnewcarPageState extends State<AddnewcarPage> {
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
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                            padding: const EdgeInsets.only(
                                                top: 10),
                                            child: SingleChildScrollView(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
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
                                                                child:
                                                                    SizedBox(
                                                                  height:
                                                                      35.2,
                                                                  child:
                                                                      TextField(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      contentPadding:
                                                                          const EdgeInsets.symmetric(vertical: 40.0),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.5),
                                                                      ),
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderSide:
                                                                            const BorderSide(color: const Color(0xffE2E8F0), width: 1),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors.white,
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
                                                                          side: BorderSide(
                                                                            color: Color(0xffE2E8F0),
                                                                            width: 0.1,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            IconButton(
                                                                          icon: Image.asset(
                                                                            'assets/images/iconscan.png',
                                                                            height: 18.94,
                                                                            width: 18.94,
                                                                          ),
                                                                          onPressed: () {},
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
                                                              horizontal:
                                                                  10.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                'สถานี',
                                                                style: TextStyleAdd
                                                                    .bodyAdd14),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right:
                                                                      10),
                                                          child:
                                                              DecoratedBox(
                                                            decoration:
                                                                BoxDecoration(
                                                                    border: new Border
                                                                        .all(
                                                                      color:
                                                                          const Color(0xffE2E8F0),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(5.5)),
                                                            child:
                                                                Container(
                                                              height: 35.2,
                                                              child:
                                                                  Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left:
                                                                        10,
                                                                    right:
                                                                        10),
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
                                                              ),
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
                                                                  right:
                                                                      10),
                                                          child: Container(
                                                            height: 200,
                                                            width: double
                                                                .infinity,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: const Color(
                                                                        0xffE2E8F0))),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right:
                                                                      10),
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
                                                                          5,
                                                                          5),
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
                                                                    height:
                                                                        87,
                                                                    width: double
                                                                        .infinity,
                                                                    child:
                                                                        Card(
                                                                      shape:
                                                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          Column(
                                                                        children: const <Widget>[
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 1),
                                                                            child: Text(
                                                                              'แถว',
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Color(0xffD4D4D4),
                                                                                fontFamily: ('IBM Plex Sans Thai'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 1),
                                                                            child: Text(
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
                                                                    height:
                                                                        87,
                                                                    width: double
                                                                        .infinity,
                                                                    child:
                                                                        Card(
                                                                      shape:
                                                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          Column(
                                                                        children: const <Widget>[
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 1),
                                                                            child: Text(
                                                                              'ลำดับ',
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Color(0xffD4D4D4),
                                                                                fontFamily: ('IBM Plex Sans Thai'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 1),
                                                                            child: Text(
                                                                              '23',
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
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                 const SizedBox(height: 130),
                                                 Padding(
                                                  padding: EdgeInsets.symmetric( horizontal: 25.0),
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
                                            onPressed: () {
                                             
                                             
                                            },
                                            child: const Text(
                                                'บันทึก',
                                                style: TextStyle(
                                                  fontFamily:
                                                      ('IBM Plex Sans Thai'),
                                                  fontWeight:
                                                      FontWeight.bold,
                                                )),
                                          )
                                             
                                                 )
                                               
                                                ])))))),
                            const SizedBox(height: 10),
                            Text('Powered by Weise Technika',
                                style: TextStyleFoot.bodyfoot),
                          ])))),
        ])));
  }
}
