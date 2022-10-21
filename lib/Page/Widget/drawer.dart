import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Page/ProfilePage/ProfilePage.dart';
import 'package:vdqims/Style/TextStyle.dart';

import '../../Service/API/AuthAPI.dart';
import '../LoginPage/LoginPage.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
            child: Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60.0),
                          child: Image.asset('assets/images/Profile.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      AutoSizeText("${userData['fullname']}" + " " + "${userData['lastname']}",
                          style: TextStyleDrawer.bodyName, maxFontSize:16 ,minFontSize: 14,),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: AutoSizeText('ข้อมูลส่วนตัว', style: TextStyleDrawer.bodyMenu, maxFontSize:14 ,minFontSize: 12,),
                        ),
                        onTap: () {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
                          });
                        },
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: AutoSizeText('ออกจากระบบ', style: TextStyleDrawer.bodyMenu, maxFontSize:14 ,minFontSize: 12,),
                        ),
                        onTap: () {
                          logout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                        },
                      ),
                    ])))
      ]),
    );
  }
}

void logout() async {
  // logout from the server ...
  var res = await LoginAPI().getData('logout');
  var body = json.decode(res.body);
  /*  if (body['success']) { */
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  localStorage.remove('token');
  localStorage.remove('user');
  localStorage.remove('ID');
  localStorage.remove('carID');
  // localStorage.remove('user');

  /*  } */
}

// suchanun0209@gmail.com
// 0831345371
