// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
          leading: Icon(Icons.menu),
          backgroundColor: baseColor1,
          title: const Text(''),
          elevation: 0,
          actions: const <Widget>[],
        ),
        body: Stack(children: <Widget>[
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'ระบบบริหารจัดการรถยนต์',
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
                            'VDQI Stock Management',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: ('IBM Plex Sans Thai'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SingleChildScrollView(
                        child:  SizedBox(
                          height: 500,
                          child: Card(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          
                            child: GridView.count(
                            padding: EdgeInsets.all(5.0),
                              crossAxisCount: 1,
                               childAspectRatio: (1 / .3),
                              crossAxisSpacing: 4.0,  
                              mainAxisSpacing: 8.0,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
                                  child:  FlatButton(
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    color: Color(0xfff5f6f9),
                                    onPressed: () {},
                                    child: Row
                                             (children:  [
                                              Image.asset(
                                            'assets/images/car1.png',
                                            height: 80.0,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(width: 19),
                                          Expanded(
                                            child:Text('ค้นหารถยนต์')
                                          
                                          ),
                                          Icon(Icons.arrow_forward_ios)

                                             ],))
                                  ),
                                   Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
                                  child:  FlatButton(
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    color: Color(0xfff5f6f9),
                                    onPressed: () {},
                                    child: Row
                                             (children:  [
                                              Image.asset(
                                            'assets/images/car1.png',
                                            height: 80.0,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(width: 19),
                                          Expanded(
                                            child:Text('เพิ่มรถยนต์ใหม่')
                                          
                                          ),
                                          Icon(Icons.arrow_forward_ios)

                                             ],))
                                  )
                                

                              ],
                            ),
                          )),
                        

                      ),
                      const SizedBox(height: 10),
                      Container(
                        child: const Text(
                          'Powered by Weise Technika',
                          style:
                              TextStyle(fontSize: 11, color: Color.fromARGB(255, 228, 223, 223),fontFamily: ('IBM Plex Sans Thai'),
                              ),
                        ),
                      ),
                    ])),
          )
        ]));
  }
}
