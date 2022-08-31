/* // ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vdqims/Page/Test/TestModel.dart';

import '../MenuPage/MenuPage.dart';
//import '../MenuPage/MenuPage.dart';

class Test extends StatefulWidget {
  @override
  const Test({Key? key}) : super(key: key);
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int currentPage = 1;

  List<Passenger> passengers = [];

  Future<bool> PassengersData() async{
    final Uri uri = Uri.parse('http://206.189.92.79/api/car?page=1');
    final response = await http.get(uri);

    if(response.statusCode ==200){
      final result = passengersDataFromJson(response.body);
      passengers = result.data;
      currentPage++;
      print(response.body);

      setState(() {
        
      });


      return true;

    }else{
      return false;
    }

  }
  @override
  void initState(){
    super.initState();
    PassengersData();
  }
  @override
  

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
        body: ListView.separated(
          itemBuilder: (context, index) {
            final passenger =passengers[index];
            return ListTile(
              title: Text(passenger.carChassis),
              subtitle: Text(passenger.carStatus.carStatus),
              
            );
            
          }, 
          separatorBuilder: (context, index) => Divider(),
          itemCount: passengers.length
          ),
        );
      
        
  }
   
}
 */