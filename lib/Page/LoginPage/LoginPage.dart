// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';
import 'package:vdqims/Service/Api.dart';
import 'package:vdqims/Style/TextStyle.dart';

import '../HomePage/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  const LoginPage({Key? key}) : super(key: key);
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ScaffoldState scaffoldState;
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Container(

            // alignment: AlignmentDirectional.center,
            height: 350,
            child: Image.asset(
              'assets/images/logo.png',
              height: 1.0,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              stops: const [0.0, 2.0],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [baseColor1, baseColor2],
            ))),
      ),
      Positioned(
          top: 20,
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 380,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Container(
                                        child: Text(
                                            "ระบบบริหารจัดการสต๊อครถยนต์",
                                            style: TextStylelogin.body16))),
                                const SizedBox(height: 15),
                                 Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(" ลงชื่อเข้าใช้งาน ",
                                        style: TextStylelogin.body20),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                 Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(" ชื่อผู้ใช้งาน",
                                        style: TextStylelogin.body14),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: SizedBox(
                                    height: 35.2,
                                    child: TextField(
                                      controller: mailController,
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
                                 Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("พาสเวิร์ด",
                                        style: TextStylelogin.body14),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: SizedBox(
                                    height: 35.2,
                                    child: TextField(
                                      controller: passwordController,
                                      obscureText: true,
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
                                const SizedBox(height: 20),
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
                                      onPressed: _login,
                                      child: const Text('เข้าสู่ระบบ',
                                          style: TextStyle(
                                            fontFamily: ('IBM Plex Sans Thai'),
                                            fontWeight: FontWeight.w600,
                                          )),
                                    )),
                              ])),
                    ),
                     const SizedBox(height: 10),
                                Text('Powered by Weise Technika',
                                    style: TextStyleFoot.bodyfoot),

                 
                  ]))),
    ]));
  }

  void _login() async {
    setState(() {
      _isLoading = true;

      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // The loading indicator
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    // Some text
                    Text('Loading...')
                  ],
                ),
              ),
            );
            // return Center(child: const CircularProgressIndicator());
          });
    });

    var data = {
      'email': mailController.text,
      'password': passwordController.text
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if (_isLoading == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      
      localStorage.setString('user', json.encode(body['user']));
   

      // ignore: use_build_context_synchronously
      /* Navigator.push(
          context, new MaterialPageRoute(builder: (context) => const FirstPage())); */

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
    }

    setState(() {
      _isLoading = false;
    });
  }
}
