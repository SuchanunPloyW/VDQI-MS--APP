// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


//import '../MenuPage/MenuPage.dart';

class Test extends StatefulWidget {
  @override
  const Test({Key? key}) : super(key: key);
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: SingleChildScrollView(
          child: Text(DateFormat("yyyy-MM-dd").format(DateTime.now())),
        )
        );
  }
}
