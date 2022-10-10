import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Page/FindcarPage/Model/FindcarModel.dart';
import '../Page/FindcarPage/Service/FindcarService.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(height: 40, width: 40,child: Text("")),
                    Container(height: 40, width: 40,child: Text("1")),
                    Container(height: 40, width: 40,child: Text("2")),
                    Container(height: 40, width: 40,child: Text("3")),
                    Container(height: 40, width: 40,child: Text("4")),
                    Container(height: 40, width: 40,child: Text("5")),
                  ]
                ),
                Row(
                  children: <Widget>[
                    Container(height: 40, width: 40,child: Text("A")),
                   InkWell(
                    
                   )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(height: 40, width: 40,child: Text("B")),
                    InkWell(onTap: () {print("10");},child:Container(height: 40, width: 40,child: Text("10"))),
                    InkWell(onTap: () {print("11");},child:Container(height: 40, width: 40,child: Text("11"))),
                    InkWell(onTap: () {print("12");},child:Container(height: 40, width: 40,child: Text("12"))),
                    InkWell(onTap: () {print("13");},child:Container(height: 40, width: 40,child: Text("13"))),
                    InkWell(onTap: () {print("13");},child:Container(height: 40, width: 40,child: Text("13"))),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(height: 40, width: 40,child: Text("C")),
                    InkWell(onTap: () {print("20");},child:Container(height: 40, width: 40,child: Text("20"))),
                    InkWell(onTap: () {print("21");},child:Container(height: 40, width: 40,child: Text("21"))),
                    InkWell(onTap: () {print("22");},child:Container(height: 40, width: 40,child: Text("22"))),
                    InkWell(onTap: () {print("23");},child:Container(height: 40, width: 40,child: Text("23"))),
                    InkWell(onTap: () {print("23");},child:Container(height: 40, width: 40,child: Text("23"))),
                  ],
                ),
              ],
            ),
      )
    );
  }}