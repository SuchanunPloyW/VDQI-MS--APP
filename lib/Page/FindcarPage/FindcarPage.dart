// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../MenuPage/MenuPage.dart';

class FindcarPage extends StatefulWidget {
  @override
  const FindcarPage({Key? key}) : super(key: key);
  State<FindcarPage> createState() => _FindcarPageState();
}

class _FindcarPageState extends State<FindcarPage> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "ค้นหารถยนต์" ,
              style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: ('IBM Plex Sans Thai'),
              fontWeight: FontWeight.bold, 
              ),
              children: const <TextSpan>[
                TextSpan(
                          text: '\nFind My Car',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: ('IBM Plex Sans Thai'),
                          ),
                        ),

              ]
              
            )
          ),
          leading: IconButton(
            onPressed: () {
              Future.delayed(Duration(seconds: 1), () {
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
        body: Stack(children: <Widget>[
          Align(    
            alignment: Alignment.topCenter,
            child: Container(
              child: TextFormField(),
                // alignment: AlignmentDirectional.center,
                height: 290,
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
                            )),
                      ),

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
        ]));
  }
}
