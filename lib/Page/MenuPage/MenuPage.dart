// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vdqims/Page/AddnewcarPage/AddnewcarPage.dart';
import 'package:vdqims/Page/MycarsPage/MycarsPage.dart';
import '../../Style/TextStyle.dart';
import '../FindcarPage/FindcarPage.dart';
import '../Widget/drawer.dart';

class MenuPage extends StatefulWidget {
  @override
  const MenuPage({Key? key}) : super(key: key);
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 20.0,
                child: ClipRRect(
                  child: Image.asset('assets/images/Profile.png'),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
          backgroundColor: baseColor1,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                'assets/images/iconMenu.png',
                height: 16.00,
                width: 26.67,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: SideMenu(),

        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  // alignment: AlignmentDirectional.center,
                  height: 298,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    stops: const [0.0, 2.0],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [baseColor1, baseColor2],
                  ))),
            ),
            Padding(
               padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child:  Text(
                                  'ระบบบริหารจัดการรถยนต์',
                                  style: TextStyleMenuName.bodyMenuThai
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:  Text(
                                'VDQI Stock Management',
                                style: TextStyleMenuName.bodyMenuEng
                              ),
                            ),
                          ),
                          
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                  height: 450,
                                  child: Card(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                    margin:
                                        const EdgeInsets.only(left: 10, right: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: GridView.count(
                                      padding: EdgeInsets.all(5.0),
                                      crossAxisCount: 1,
                                      childAspectRatio: (1 / .3),
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 1.0,
                                      children: <Widget>[
                                        //------------------------------- ค้นหา  -----------------------------------
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Color(0xffF6F6F6),
                                                      blurRadius: 20,
                                                      offset: Offset(5, 5),
                                                    ),
                                                  ],
                                                ),
                                                child: ElevatedButton(
                                                   style: ElevatedButton.styleFrom(
                                                    primary: Color(0xffFFFFFF), // background
                                                    onPrimary: Color.fromARGB(255, 224, 197, 197),
                                                    padding: EdgeInsets.all(20),
                                                    shape: RoundedRectangleBorder(
                                                       borderRadius:BorderRadius.circular(10),     
                                                    )
                                                   ),
                                                   
                                                  child: Row(children: [
                                                    Container(
                                                          child: Image.asset(
                                                            'assets/images/car2.png',
                                                            height: 45.0,
                                                            width: 45,
                                                          ),
                                                        ),
                                                         SizedBox(width: 30),
                                                         Expanded(
                                                            child: Text(
                                                                ' ค้นหารถยนต์ \n Find My Car',
                                                                style: TextStyle(
                                                                  color: Color(0xff404040),
                                                                  fontFamily:
                                                                      ('IBM Plex Sans Thai'),
                                                                ))),
                                                                 Icon(Icons.arrow_forward_ios,
                                                                 color: Color(0xffDDDDDD) ,)
                                                  ]),
                                                  onPressed: () {
                                                     Future.delayed(
                                                       Duration(milliseconds: 500),(() {
                                                         Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FindcarPage()));
                                                       })
                                                     );
                                                  }, 
                                                ),
                                                )),

                                        //------------------------------- ค้นหา  -----------------------------------
                                        //------------------------------- เพิ่มรถ  -----------------------------------
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Color(0xffF6F6F6),
                                                      blurRadius: 20,
                                                      offset: Offset(5, 5),
                                                    ),
                                                  ],
                                                ),
                                                child: ElevatedButton(
                                                   style: ElevatedButton.styleFrom(
                                                    primary: Color(0xffFFFFFF), // background
                                                    onPrimary: Color.fromARGB(255, 224, 197, 197),
                                                    padding: EdgeInsets.all(20),
                                                    shape: RoundedRectangleBorder(
                                                       borderRadius:BorderRadius.circular(10),     
                                                    )
                                                   ),
                                                   
                                                  child: Row(children: [
                                                    Container(
                                                          child: Image.asset(
                                                            'assets/images/plus.png',
                                                            height: 45.0,
                                                            width: 45,
                                                          ),
                                                        ),
                                                         SizedBox(width: 30),
                                                         Expanded(
                                                            child: Text(
                                                                ' เพิ่มรถยนต์ใหม่ \n Add New Car',
                                                                style: TextStyle(
                                                                  color: Color(0xff404040),
                                                                  fontFamily:
                                                                      ('IBM Plex Sans Thai'),
                                                                ))),
                                                                 Icon(Icons.arrow_forward_ios,
                                                                 color: Color(0xffDDDDDD) ,)
                                                  ]),
                                                  onPressed: () {
                                                     Future.delayed(
                                                       Duration(milliseconds: 500),(() {
                                                         Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AddnewcarPage()));
                                                       })
                                                     );
                                                  }, 
                                                ),
                                                /* child: ElevatedButton(
                                                   style: ElevatedButton.styleFrom(
                                                    // ignore: deprecated_member_use
                                                    primary: Color(0xffFFFFFF), // background
                                                    onPrimary: Color.fromARGB(255, 224, 197, 197), // foreground
                                                    padding: EdgeInsets.all(20),
                                                    shape: RoundedRectangleBorder(
                                                       borderRadius:BorderRadius.circular(10),     
                                                    )
                                                   ),
                                                    
                                                  child: Row(children: [
                                                    Container(
                                                          child: Image.asset(
                                                            'assets/images/plus.png',
                                                            height: 45.0,
                                                            width: 45,
                                                          ),
                                                        ),
                                                         SizedBox(width: 30),
                                                         Text(
                                                             ' เพิ่มรถยนต์ใหม่ \n Add New Car',
                                                             style: TextStyle(
                                                               color: Color(0xff404040),
                                                               fontFamily:
                                                                   ('IBM Plex Sans Thai'),
                                                             )),
                                                                 Icon(Icons.arrow_forward_ios,
                                                                 color: Color(0xffDDDDDD) ,)
                                                  ]),
                                                  onPressed: () {
                                                     Future.delayed(
                                                       Duration(milliseconds: 500),(() {
                                                         Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AddnewcarPage()));
                                                       })
                                                     );
                                                  }, 
                                                ), */
                                              
                                                    )),
                    
                                        //------------------------------- เพิ่มรถ  -----------------------------------
                                        //------------------------------- รถยนต์ของฉัน  -----------------------------------
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Color(0xffF6F6F6),
                                                      blurRadius: 20,
                                                      offset: Offset(5, 5),
                                                    ),
                                                  ],
                                                ),
                                               child: ElevatedButton(
                                                   style: ElevatedButton.styleFrom(
                                                    // ignore: deprecated_member_use
                                                    primary: Color(0xffFFFFFF), // background
                                                    onPrimary: Color.fromARGB(255, 224, 197, 197), // foreground
                                                    padding: EdgeInsets.all(20),
                                                    shape: RoundedRectangleBorder(
                                                       borderRadius:BorderRadius.circular(10),     
                                                    )
                                                   ),
                                                    
                                                  child: Row(children: [
                                                    Container(
                                                          child: Image.asset(
                                                            'assets/images/car3.png',
                                                            height: 45.0,
                                                            width: 45,
                                                          ),
                                                        ),
                                                         SizedBox(width: 30),
                                                         Expanded(
                                                            child: Text(
                                                                ' รถยนต์ของฉัน \n My Cars',
                                                                style: TextStyle(
                                                                  color: Color(0xff404040),
                                                                  fontFamily:
                                                                      ('IBM Plex Sans Thai'),
                                                                ))),
                                                                 Icon(Icons.arrow_forward_ios,
                                                                 color: Color(0xffDDDDDD) ,)
                                                  ]),
                                                  onPressed: () {
                                                     Future.delayed(
                                                       Duration(milliseconds: 500),(() {
                                                         Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MycarsPage()));
                                                       })
                                                     );
                                                  }, 
                                                ), 








                                                // ignore: deprecated_member_use
                                                /* child: FlatButton(
                                                    padding: EdgeInsets.all(20),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(10),
                                                        side: BorderSide(
                                                            color: Color(0xffF6F6F6),
                                                            width: 2,
                                                            style:
                                                                BorderStyle.solid)),
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    onPressed: () {
                                                      Future.delayed(
                                                          Duration(milliseconds: 500),
                                                          () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MycarsPage()));
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Image.asset(
                                                            'assets/images/car3.png',
                                                            height: 45.0,
                                                            width: 45,
                                                          ),
                                                        ),
                                                        SizedBox(width: 30),
                                                        Expanded(
                                                            child: Text(
                                                                ' รถยนต์ของฉัน \n My Cars',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      ('IBM Plex Sans Thai'),
                                                                ))),
                                                        Icon(Icons.arrow_forward_ios)
                                                      ],
                                                    )) */
                                                    
                                                    )),
                                        //------------------------------- เบิกรถ  -----------------------------------
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Powered by Weise Technika',
                              style: TextStyleFoot.bodyfoot),
                        ])),
              ),
            )
          ]),
        ));
  }
}
