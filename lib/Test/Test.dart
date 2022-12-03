import 'dart:async';

import 'package:flutter/material.dart';

import '../Service/API/PositionAPI.dart';
import '../Service/Model/PositDBModel.dart';
import '../Style/TextStyle.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return AA();
  }

  Widget AA() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          if (_isLoading) ...[
            const CircularProgressIndicator(),
          ] else ...[
            A(),
          ],
        ],
      ),
    );
  }

  Widget A() {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
            child: Column(
          children: [
            Center(
              child: Text(
                "Stock A",
                style: TextStyleAlert.body18bold,
                textScaleFactor: 1,
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.red,
                      height: 30,
                      width: 30,
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "A",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "B",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "C",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                          Text(
                            "D",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1,
                          ),
                        ],
                      ),
                    )
                    ),

                  ],
                )
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                  ),
                )
               
          ],
        )));
  }
}
