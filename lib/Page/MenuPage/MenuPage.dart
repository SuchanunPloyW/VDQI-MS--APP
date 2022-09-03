// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../FindcarPage/FindcarPage.dart';

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
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.9, -0.25),
                child: Container(
                  width: 45,
                  height: 45,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/147/147140.png',
                  ),
                ),
              ),
             
            ],


          )
          
          /* actions: const <Widget>[
             CircleAvatar(
             backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/147/147140.png'),
             radius: 20,
            ),
          ], */
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
                          height: 450,
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
                              mainAxisSpacing: 1.0,
                              children: <Widget>[
                              //------------------------------- ค้นหา  -----------------------------------  
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
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
                                   // ignore: deprecated_member_use
                                   child:  FlatButton(
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10) , 
                                      side: BorderSide(color: Color(0xffF6F6F6), width: 2 ,
                                      style: BorderStyle.solid
                                      )
                                      ),
                                    color: const Color.fromARGB(255, 255, 255, 255),                     
                                    onPressed: () {
                                      Future.delayed(Duration(milliseconds: 500), () {
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => FindcarPage())); }); 
                                    },
                                    child: Row(
                                      children:  [
                                        Container(
                                          child: Image.asset(
                                            'assets/images/car2.png',
                                            height: 45.0,
                                            width: 45,
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        Expanded(
                                            child:Text(' ค้นหารถยนต์ \n Find My Car',
                                            style: TextStyle(
                                              fontFamily: ('IBM Plex Sans Thai'),))
                                                ),
                                              Icon(Icons.arrow_forward_ios)],)))),    
                        
                        //------------------------------- ค้นหา  -----------------------------------
                        //------------------------------- เพิ่มรถ  -----------------------------------
                        Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
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
                                   // ignore: deprecated_member_use
                                   child:  FlatButton(
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10) , 
                                      side: BorderSide(color: Color(0xffF6F6F6), width: 2 ,
                                      style: BorderStyle.solid
                                      )
                                      ),
                                    color: const Color.fromARGB(255, 255, 255, 255),                     
                                    onPressed: () {},
                                    child: Row(
                                      children:  [
                                        Container(
                                          child: Image.asset(
                                            'assets/images/plus.png',
                                            height: 45.0,
                                            width: 45,
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        Expanded(
                                            child:Text(' เพิ่มรถยนต์ใหม่ \n Add New Car',
                                            style: TextStyle(
                                              fontFamily: ('IBM Plex Sans Thai'),))
                                                ),
                                              Icon(Icons.arrow_forward_ios)],)))),    

                        //------------------------------- เพิ่มรถ  -----------------------------------
                        //------------------------------- เบิกรถ  -----------------------------------
                        Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
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
                                   // ignore: deprecated_member_use
                                   child:  FlatButton(
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10) , 
                                      side: BorderSide(color: Color(0xffF6F6F6), width: 2 ,
                                      style: BorderStyle.solid
                                      )
                                      ),
                                    color: const Color.fromARGB(255, 255, 255, 255),                     
                                    onPressed: () {},
                                    child: Row(
                                      children:  [
                                        Container(
                                          child: Image.asset(
                                            'assets/images/car3.png',
                                            height: 45.0,
                                            width: 45,
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        Expanded(
                                            child:Text(' เบิกรถยนต์ \n Withdraw',
                                            style: TextStyle(
                                              fontFamily: ('IBM Plex Sans Thai'),))
                                                ),
                                              Icon(Icons.arrow_forward_ios)],)))),   
                             //------------------------------- เบิกรถ  -----------------------------------                 
                              ],
                            ),
                          )),
                      ),
                      
                      const SizedBox(height: 10),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: const Text(
                          'Powered by Weise Technika',
                          style:
                              TextStyle(fontSize: 11, color: Color.fromARGB(255, 228, 223, 223),fontFamily: ('IBM Plex Sans Thai'),),
                              
                        ),
                      ),
                    ])),
          )
        ]));
  }
}