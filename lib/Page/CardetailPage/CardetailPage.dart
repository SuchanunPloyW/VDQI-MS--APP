// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';
//import '../MenuPage/MenuPage.dart';

class CardetailPage extends StatefulWidget {
  @override
  const CardetailPage({Key? key}) : super(key: key);
  State<CardetailPage> createState() => _CardetailPageState();
}

class _CardetailPageState extends State<CardetailPage> {
  

  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "รายละเอียดรถยนต์",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: ('IBM Plex Sans Thai'),
                    fontWeight: FontWeight.bold,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text: '\nCar Infomation',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: ('IBM Plex Sans Thai'),
                      ),
                    ),
                  ])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(Duration(milliseconds: 200), () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MenuPage()));
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 30,
            ),
          ),
          backgroundColor: baseColor1,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body:
         SingleChildScrollView(
           child: Stack(
            children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                // alignment: AlignmentDirectional.center,
                height: 290,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  stops: const [0.0, 2.0],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [baseColor1, baseColor2],
                )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          SizedBox(
                              height: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  margin:
                                      const EdgeInsets.only(left: 10, right: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (_, index){
                            return ListTile(
                              title: Text('MNTADFC56966FGTY'),
                            );
                          }
                        )
                                ),
                              )),
                        
         
                        const SizedBox(height: 10),
                        // ignore: avoid_unnecessary_containers
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
            )
                 ]),
         ));
  }
   
}
