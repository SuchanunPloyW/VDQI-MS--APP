import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Style/TextStyle.dart';
import '../MenuPage/MenuPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  TextEditingController _namecontroller = new TextEditingController();
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);





  @override
  Widget build(BuildContext context) {
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
                                       ) ,
                   
                     )
                   
                     ),
                   ),
                    SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                       child: SizedBox(
                        height: 500,
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)), 
                         
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                               Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(" ชื่อ",
                                              style: TextStylelogin.body14),
                                  ),
                                ),
                                Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                child: SizedBox(
                                  height: 35.2,
                                  child: TextField(
                                    enabled: false, 
                                    controller:TextEditingController(text: "${userData['fullname']}"),
      
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 40.0),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(" นามสกุล",
                                              style: TextStylelogin.body14),
                                  ),
                                ),
                                Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                child: SizedBox(
                                  height: 35.2,
                                  child: TextField(
                                    enabled: false, 
                                    controller:TextEditingController(text: "${userData['lastname']}"),
      
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 40.0),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 300),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xffE52628),
                                        minimumSize:
                                            const Size.fromHeight(40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: (() {
                                      
                                    }),
                                    child: const Text('แก้ไข',
                                        style: TextStyle(
                                          fontFamily: ('IBM Plex Sans Thai'),
                                          fontWeight: FontWeight.w600,
                                        )),
                                  )),
                            ],
                          ),
                                     
                        )

                       ),
                       
                    )
                   ),



             const SizedBox(height: 10),
                              Text('Powered by Weise Technika',
                                  style: TextStyleFoot.bodyfoot),
                 ],
                )
               )
            ),
              
               
         ])
      )

    );
  }
}