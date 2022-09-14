import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Service/Api.dart';
import '../LoginPage/LoginPage.dart';

  
class SideMenu extends StatelessWidget {
 
    const SideMenu({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
        return Drawer(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                       CircleAvatar(
                        radius: 70.0,
                        child: ClipRRect(
                          child: Image.asset('assets/images/Profile.png'),
                          borderRadius: BorderRadius.circular(70.0),
                        ),
                       ),
                       const SizedBox(height: 10.0,),
                       const Text( "สุชานันท์ แพรวนภา",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff737373)
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        ListTile(
                        title: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('ข้อมูลส่วนตัว',
                          style:  TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff858585)
                            ),
                          ),
                        ),
                        onTap: () { },
                      ),  
                      
                        ListTile(
                        title: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('ออกจากระบบ',
                          style:  TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff858585)
                            ),
                          ),
                        ),
                        onTap: () { 
                           logout();
                            Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false);
                        },
                      ),    

                    ]

                   )
                )
              )

            ]
            

          ),
            
        );
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

}