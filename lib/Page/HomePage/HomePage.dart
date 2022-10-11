// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';

import '../../Style/TextStyle.dart';
import '../Widget/drawer.dart';

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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
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
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text('หน้าหลัก', style: TextStyleMenuName.bodyMenuThai),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Home Page', style: TextStyleMenuName.bodyMenuEng),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                              height: 450,
                              child: Card(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                margin: const EdgeInsets.only(left: 10, right: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                              Navigator.push(context, MaterialPageRoute(builder: (_) => MenuPage()));
                                            });
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
                                                style: TextStylePage.bodyP10
                                              ),
                                              Text(
                                                'VDQI Stock Management',
                                                style: TextStylePage.bodyP10
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
                                              style: TextStylePage.bodyP10
                                            ),
                                            Text(
                                              'Setting',
                                              style: TextStylePage.bodyP10
                                            )
                                          ],
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Powered by Weise Technika', style: TextStyleFoot.bodyfoot),
                    ])),
              ),
            )
          ]),
        ));
  }
}
