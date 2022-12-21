// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';
import 'package:vdqims/Page/MycarsdetailPage/MycarsdetailPage.dart';
import 'package:vdqims/Style/TextStyle.dart';
import 'package:http/http.dart' as http;

import '../../Service/Model/ReqDBModel.dart';

class MycarsPage extends StatefulWidget {
  const MycarsPage({Key? key}) : super(key: key);

  @override
  State<MycarsPage> createState() => _MycarsPageState();
}

class _MycarsPageState extends State<MycarsPage> {
  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
  }

  @override
  Future<List<ReqDBAPI>> getfullname() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(
        Uri.parse('https://vdqi-db.toyotaparagon.com/api/reqDB/mycar/${userData['id']}'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
        });
    // return value
    var req = ReqDB.fromJson(jsonDecode(response.body));
    return req.data;
  }

  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "รถยนต์ของฉัน",
                  style: TextStyleMenuName.bodyMenuThai,
                  children: <TextSpan>[
                    TextSpan(
                        text: '\nMy Cars',
                        style: TextStyleMenuName.bodyMenuEng),
                  ])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MenuPage()));
              });
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 30,
            ),
          ),
          backgroundColor: baseColor1,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
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
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: 650,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.05),
                                          blurRadius: 12,
                                          spreadRadius: 5
                                          /*   offset: Offset(0, 3), */
                                          ),
                                    ]),
                                child: FutureBuilder(
                                  future: getfullname(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<ReqDBAPI>?> snapshot) {
                                    if (snapshot.hasData) {
                                      List<ReqDBAPI>? data = snapshot.data;

                                      return Align(
                                        alignment: Alignment.topCenter,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: data!.length,
                                          itemBuilder: (context, index) =>
                                              Listcar(
                                            model: data[index],
                                          ),
                                          /*  Listcar(model: data[index],),  */
                                        ),
                                      );
                                    }
                                    return const Center(
                                        /*  child:CircularProgressIndicator() */
                                        /* Text(
                                        'ไม่พบรถยนต์ในรายการของฉัน',
                                        style: TextStyle(
                                          fontFamily: ('Bai Jamjuree'),
                                        ),
                                        textScaleFactor: 1,
                                      ), */
                                        );
                                  },
                                ),
                              ),
                            )),
                        const SizedBox(height: 10),
                        Text('Powered by Weise Technika',
                            style: TextStyleFoot.bodyfoot),
                      ])),
            )
          ]),
        ));
  }

  Widget Listcar({required ReqDBAPI model}) {
    return InkWell(
      onTap: () async {
        dynamic carID = model.carid.car_id.toString();
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('carID', carID);

        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MycarsdetailPage(
                      model: model,
                    )));
      }, //<<<<<<<<<< push to new screen เช่น
      child: SizedBox(
        height: 100,
        width: 55,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10,
                      spreadRadius: 5),
                ]),
            child: ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(1.0)),
                  child: Image.asset(
                    'assets/images/car3.png',
                    height: 60.0,
                    width: 60,
                  ),
                ),
              ),
              title: Text(
                model.carid.car_chassis,
                style: TextStyleMycar.title,
                textScaleFactor: 1,
              ),
              /*  desc: (' คุณต้องการทำรายการเบิกรถยนต์' + "\n" + widget.model.carChassis + " ใช่หรือไม่"), */
              subtitle: Text(
                'รถยนต์ \nสถานที่ : ' + model.carid.carWhere.carWhere,
                style: TextStyleMycar.subtitle,
                textScaleFactor: 1,
              ),
            ),
            /*  child:
                Column(children: [Text(model.carChassis)]), */
          ),
        ),
      ),
    );
  }
}
