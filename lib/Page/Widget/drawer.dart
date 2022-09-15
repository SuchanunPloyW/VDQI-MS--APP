import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Page/ProfilePage/ProfilePage.dart';

import '../../Service/Api.dart';
import '../LoginPage/LoginPage.dart';
import '../MenuPage/MenuPage.dart';


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
                          child: Image.asset('assets/images/Profile.png'),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                       Text(
                        "${userData['fullname']}" + " " + "${userData['lastname']}",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff737373)),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                        title: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'ข้อมูลส่วนตัว',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff858585)),
                          ),
                        ),
                        onTap: () {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ProfilePage()));
                          });
                        },
                      ),
                      ListTile(
                        title: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'ออกจากระบบ',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff858585)),
                          ),
                        ),
                        onTap: () {
                          logout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false);
                        },
                      ),
                    ])))
      ]),
    );
  }
}
 void logout() async {
    // logout from the server ...
    var res = await CallApi().getData('logout');

    var body = json.decode(res.body);
    /*  if (body['success']) { */
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('user');
    // localStorage.remove('user');

    /*  } */
  }
