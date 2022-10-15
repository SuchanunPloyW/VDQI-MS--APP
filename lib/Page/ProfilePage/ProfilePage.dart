import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Style/TextStyle.dart';
import '../MenuPage/MenuPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //<--------------------- get user ----------------->
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
  //<--------------------- Controller ----------------->

  TextEditingController _namecontroller = new TextEditingController();

  //<--------------------- variable  ----------------->
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);

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
                  text: "ข้อมูลส่วนตัว",
                  style: TextStyleMenuName.bodyMenuThai,
                  children: <TextSpan>[
                    TextSpan(
                        text: '\nProfile',
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
              // alignment: AlignmentDirectional.center,
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
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 72,
                        child: CircleAvatar(
                          radius: 70.0,
                          child: ClipRRect(
                            child: Image.asset('assets/images/Profile.png'),
                            borderRadius: BorderRadius.circular(70.0),
                          ),
                        )),
                  ),
                  SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                        height: 400,
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " ชื่อ",
                                    style: TextStylelogin.body16,
                                    maxLines: 1,
                                   textScaleFactor: 1.0
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Center(
                                    child: SizedBox(
                                      height: 40,
                                      child: MediaQuery(
                                        data: mqDataNew,
                                        child: TextFormField(
                                          readOnly: true,
                                           controller: TextEditingController(
                                            text: "${userData['fullname']}"),
                                           keyboardType: TextInputType.text,
                                           decoration: InputDecoration(
                                            /* contentPadding:EdgeInsets.fromLTRB(left, top, right, bottom) */
                                            contentPadding:EdgeInsets.fromLTRB(10, 10, 5, 0),
                                            /* contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), */
                                             border: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0) )
                                           ),
                                           style: TextStylelogin.body16b,
                                           
                                        ),
                                      ),
                                    ),

                                  ),
                                ),

                            
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " นามสกุล",
                                    style: TextStylelogin.body16,
                                    maxLines: 1,
                                    textScaleFactor: 1.0
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Center(
                                    child: SizedBox(
                                      height: 40,
                                      child: MediaQuery(
                                        data: mqDataNew,
                                        child: TextFormField(
                                          readOnly: true,
                                           controller: TextEditingController(
                                            
                                            text: "${userData['lastname']}"),
                                           keyboardType: TextInputType.text,
                                           decoration: InputDecoration(
                                            /* contentPadding:EdgeInsets.fromLTRB(left, top, right, bottom) */
                                            contentPadding:EdgeInsets.fromLTRB(10, 10, 5, 0),
                                            /* contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), */
                                             border: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0) )
                                           ),
                                           style: TextStylelogin.body16b,
                                           
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                              /* Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: SizedBox(
                                  height: 35.2,
                                  child: TextField(
                                    style: TextStylelogin.body16,
                                    readOnly: true,
                                    controller: TextEditingController(
                                        text: "${userData['lastname']}"),
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 25.0),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ), */
                              const SizedBox(height: 150),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xffE52628),
                                        minimumSize: const Size.fromHeight(40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: (() {}),
                                    child: const AutoSizeText(
                                      'แก้ไข',
                                      style: TextStyle(
                                        fontFamily: ('IBM Plex Sans Thai'),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      maxFontSize: 12,
                                        minFontSize: 11,
                                    ),
                                  )),
                            ],
                          ),
                        )),
                  )),
                  const SizedBox(height: 10),
                  Text('Powered by Weise Technika',
                      style: TextStyleFoot.bodyfoot,textScaleFactor: 1.0),
                ],
              ))),
        ])));
  }
}
