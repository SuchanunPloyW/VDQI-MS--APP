import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  @override
  const HomePage({Key? key}) : super(key: key);
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /* appBar: AppBar(
        title: Text('dd'),
        flexibleSpace: Container(
           decoration: BoxDecoration(
            gradient: LinearGradient(
               colors: [
                  Color(0xffE52628),
              Color(0xffA10002),
                ]
            )
           )
        )
      ), */
        body: Stack(children: <Widget>[
      Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffE52628),
                Color(0xffA10002),
              ],
            ))),
          ),
          Expanded(
              flex: 2,
              child: Container(
                color: Color(0xffF5F5F5),
              ))
        ],
      ),
      Container(
        height: 900,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 180.0, 20, 50.0),
          child: Card(
            color: Colors.white,
            child: ListView(),
          ),
        ),
      )
      /*  Padding(
        
      
        child: Card(
          
          child: ListView(

          ) ,
        ),
      ) */
    ]));
  }
}
