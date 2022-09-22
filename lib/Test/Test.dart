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
  final List<String> one = [
      '1',
      '2',
      '3'
    ];
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    itemCount: one.length,
                    controller: ScrollController(),
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => Container(
                      height: 50,
                      color: Colors.white,
                      child: RadioListTile(title: Text(one[index]),
                        value: one[index],
                        groupValue: _oneValue,
                        onChanged: (value) {
                          setState(() {
                            _oneValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ListView.separated(
                    controller: ScrollController(),
                    itemCount: two.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => Container(
                      height: 50,
                      color: Colors.white,
                      child: RadioListTile(title: Text(two[index]),
                        value: two[index],
                        groupValue: _twoValue,
                        onChanged: (value) {
                          setState(() {
                            _twoValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ListView.separated(
                    controller: ScrollController(),
                    itemCount: three.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => Container(
                      height: 50,
                      color: Colors.white,
                      child: RadioListTile(title: Text(three[index]),
                        value: three[index],
                        groupValue: _threeValue,
                        onChanged: (value) {
                          setState(() {
                            _threeValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
}
