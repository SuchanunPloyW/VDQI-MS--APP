// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Service/API/PositionAPI.dart';
import '../Service/Model/PositionModel.dart';

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
  final List<String> one = ['1', '2', '3'];
  final List<String> two = ['1', '2', '3'];
  final List<String> three = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  var _oneValue = '';

  var _twoValue = '';

  var _threeValue = '';
  String? selected = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          /* child: Column(
            children: [
               Container(
            height: 220,
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 2,
              child: Container(
                color: Colors.cyanAccent,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: GridView.count(
                  crossAxisCount: 10,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: List<Widget>.generate(
                    50,
                    (index) => Container(
                      width: 10,
                      height: 10,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: Text("HELLO"),
            ),
          )


            ]), */
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 197, 170, 170).withOpacity(0.5),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ฝั่ง K.8",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /*  Container(
                          color: Colors.grey,
                          height: 450,
                          width: 30,
                        ), */
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "A",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "B",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "D",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "E",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "F",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                Container(
                                    height: 400,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                      color:
                                          Color.fromARGB(246, 231, 230, 236),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text('Forest'),
                                    )),
                              ]),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Container(
                            child: FutureBuilder(
                                future: PostionService().getposition(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<PositionAPI>?>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    List<PositionAPI>? data = snapshot.data;
                                    return GridView.builder(
                                        padding: EdgeInsets.all(10),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          crossAxisCount: 6,
                                        ),
                                        itemCount: data!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black38,
                                              ),
                                              color: (selected == data[index].car_position) ? Colors.red : Color(0xff89EB80),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selected = data[index]
                                                      .car_position;
                                                  print(data[index]
                                                      .car_position);
                                                });
                                              },
                                            ),
                                          );
                                        });
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: baseColor1,
                                    ),
                                  );
                                }),
                          ))
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
