// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Service/API/AuthAPI.dart';
import 'package:vdqims/SplashScreen/loginSplash.dart';
import 'package:vdqims/Style/TextStyle.dart';

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
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: Stack(children: <Widget>[
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                  height: 300,
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        stops: const [0.0, 2.0],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [baseColor1, baseColor2],
                      )),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 250,
                            width: 250,
                          ))))),
          Positioned(
            top: 180,
            child: Container(
              height: 350,
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    const BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        blurRadius: 12,
                        spreadRadius: 5),
                  ]),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    child: Text(
                      "ระบบบริหารจัดการสต๊อครถยนต์",
                      style: TextStylelogin.body16,
                      textScaleFactor: 1.0,
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(" ลงชื่อเข้าใช้งาน ",
                        style: TextStylelogin.body20, textScaleFactor: 1.0),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(" ชื่อผู้ใช้งาน",
                        style: TextStylelogin.body16, textScaleFactor: 1.0),
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      child: MediaQuery(
                        data: mqDataNew,
                        child: TextFormField(
                          controller: mailController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(

                              /* contentPadding:EdgeInsets.fromLTRB(left, top, right, bottom) */
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 0),

                              /* contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), */
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.5))),
                          style: TextStylelogin.body15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(" พาสเวิร์ด",
                        style: TextStylelogin.body16, textScaleFactor: 1.0),
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      child: MediaQuery(
                        data: mqDataNew,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            /* contentPadding:EdgeInsets.fromLTRB(left, top, right, bottom) */
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            /* contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), */
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.5)),
                          ),
                          style: TextStylelogin.body15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 280,
                    height: 36.55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xffE52628),
                          minimumSize: const Size.fromHeight(40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: _login,
                      child: AutoSizeText(
                        'เข้าสู่ระบบ',
                        style: TextStyleBtn.bodybtn,
                        maxFontSize: 12,
                        minFontSize: 11,
                      ),
                    ),
                  ),
                ),
                /*  const SizedBox(height: 60),
                     Text('Powered by Weise Technika',
                      style: TextStyleFoot.bodyfoot, textScaleFactor: 1.0), */
              ]),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height - 50,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text('Powered by Weise Technika',
                      style: TextStyleFoot.bodyfoot, textScaleFactor: 1.0),
                ],
              ))

/* const SizedBox(height: 10),
                        Text('Powered by Weise Technika',
                            style: TextStyleFoot.bodyfoot,
                            textScaleFactor: 1.0),
                      ]))), */
        ]));
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': mailController.text,
      'password': passwordController.text
    };

    var res = await LoginAPI().postData(data, 'login');
    var body = json.decode(res.body);
    if (res.statusCode == 201) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginSplash()),
          (Route<dynamic> route) => false);
    } else {
      _ErrorLogin(context);
    }

    setState(() {
      _isLoading = false;
    });
  }
}

_ErrorLogin(context) {
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
          "ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง",
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
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const LoginPage()));
        },
        color: const Color(0xff44A73B),
        child: Text("ตกลง", style: TDialogButton.body14),
      ),
    ],
  ).show();
}
