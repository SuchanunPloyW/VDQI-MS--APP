// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';

class HomePage extends StatefulWidget {
  @override
  const HomePage({Key? key}) : super(key: key);
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          backgroundColor: baseColor1,
          elevation: 0,
          actions: const <Widget>[
            
            CircleAvatar(
             backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/147/147140.png'),
             radius: 20,
            ),
           
          ],
        ),

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
               padding: const EdgeInsets.only( top: 30),
              child: SingleChildScrollView(
                child: Positioned(
                  top: 15,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'หน้าหลัก',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontFamily: ('IBM Plex Sans Thai'),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Home Page',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontFamily: ('IBM Plex Sans Thai'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            SingleChildScrollView(
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
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 8.0,
                                      children: <Widget>[
                                        Container(
                                          
                                          child: Card(
                                          margin: EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Future.delayed(Duration(milliseconds: 300), () {
                                                 Navigator.push(context, MaterialPageRoute(builder: (_) => MenuPage())); }); 
                                           
                                            },
                                            splashColor: Colors.red,
                                            child: Center(
                                                child: Column(
                                              children: <Widget>[
                                                const SizedBox(height: 15),
                                                Image.asset(
                                                  'assets/images/car1.png',
                                                  height: 80.0,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(height: 15),
                                                Text(
                                                  'ระบบบริหารจัดการสต๊อครถยนต์',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        ('IBM Plex Sans Thai'),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  'VDQI Stock Management',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        ('IBM Plex Sans Thai'),
                                                  ),
                                                )
                                              ],
                                            )),
                                          ),
                                        ),
                                          
                                        ),
                                        
                                        Card(
                                          margin: EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {},
                                            splashColor: Colors.red,
                                            child: Center(
                                                child: Column(
                                              children: <Widget>[
                                                const SizedBox(height: 15),
                                                Image.asset(
                                                  'assets/images/setting.png',
                                                  height: 80.0,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  'ตั้งค่าการใช้งาน',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        ('IBM Plex Sans Thai'),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  'Setting',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        ('IBM Plex Sans Thai'),
                                                  ),
                                                )
                                              ],
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              child: const Text(
                                'Powered by Weise Technika',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromARGB(255, 228, 223, 223),
                                  fontFamily: ('IBM Plex Sans Thai'),
                                ),
                              ),
                            ),
                          ])),
                ),
              ),
            )
          ]),
        ));
  }
}
