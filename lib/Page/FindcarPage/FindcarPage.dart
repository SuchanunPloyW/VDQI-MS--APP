// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Page/CardetailPage/CardetailPage.dart';
import 'package:vdqims/Style/TextStyle.dart';
import '../../Service/Model/CarDBModel.dart';
import '../MenuPage/MenuPage.dart';
import 'Service/FindcarService.dart';

class FindcarPage extends StatefulWidget {
  @override
  const FindcarPage({Key? key}) : super(key: key);
  State<FindcarPage> createState() => _FindcarPageState();
}

class _FindcarPageState extends State<FindcarPage> {
  String qrCode = '';
  TextEditingController chassisController = TextEditingController(text: '');

  @override
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
  @override

  /*  void initState() {
    super.initState();
     chassisController.text = '$qrCode';
  } */
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "ค้นหารถยนต์",
                  style: TextStyleMenuName.bodyMenuThai,
                  children: <TextSpan>[
                    TextSpan(
                        text: '\nFind My Car',
                        style: TextStyleMenuName.bodyMenuEng),
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

                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [
                        Flexible(
                          child: MediaQuery(
                            data: mqDataNew,
                            child: TextFormField(
                              /* onChanged: (String? value) {
                                setState(() {
                                  qrCode = value.toString();
                                });
                              }, */
                              onChanged: (String? value) {
                                setState(() {
                                  qrCode = value.toString();
                                });
                              },
                              controller: chassisController =
                                  TextEditingController(text: "$qrCode"),
                              decoration: InputDecoration(
                                  fillColor: Color(0xff9F1E1E),
                                  filled: true,
                                  hintText: "แสกนค้นหาเลขตัวถัง",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontFamily: ('Bai Jamjuree'),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(left: 15, right: 10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  suffixIconColor: Colors.grey),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  wordSpacing: 1),
                              /*  readOnly: true, */
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () => scanQRCode(),
                          child: SizedBox(
                            height: 65,
                            width: 65,
                            child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                color: Color(0xff9F1E1E),
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/images/iconscan.png',
                                    height: 18.94,
                                    width: 18.94,
                                  ),
                                  onPressed: () => scanQRCode(),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 5,
                right: 5,
              ),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 46),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: 550,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: FutureBuilder(
                                  future: FindCarService().getcar(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<CarDBAPI>?> snapshot) {
                                    if (snapshot.hasData) {
                                      List<CarDBAPI>? data = snapshot.data;
                                      return Align(
                                        alignment: Alignment.topCenter,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: data!.length,
                                            itemBuilder: (context, index) {
                                              //String postion = snapshot.data[index]
                                              if (chassisController
                                                  .text.isEmpty) {
                                                return Listcar(
                                                  model: data[index],
                                                );
                                              } else if (snapshot
                                                  .data![index].carChassis
                                                  .contains(
                                                      chassisController.text)) {
                                                return Listcar(
                                                  model: data[index],
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }
                                            /*  Listcar(model: data[index],),  */
                                            ),
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: baseColor1,
                                      ),
                                    );
                                  },
                                ),
                              )),
                          const SizedBox(height: 10),
                          Text(
                            'Powered by Weise Technika',
                            style: TextStyleFoot.bodyfoot,
                            textScaleFactor: 1,
                          ),
                        ])),
              ),
            )
          ]),
        ));
  }

  Widget Listcar({required CarDBAPI model}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 3,
            left: 5,
            right: 5,
          ),
          child: ListTile(
            onTap: () async {
              dynamic Id = model.carId.toString();
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString('ID', Id);
              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CardetailPage(
                            model: model,
                          )));
            },
            leading: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(1.0)),
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/images/car4.png',
                      height: 28.0,
                      width: 30,
                    ),
                    radius: 62.0,
                    backgroundColor: (model.carStatus.statusId == 1
                        ? const Color(0xff89EB80)
                        : const Color(0xffEB8080)),
                  )),
            ),
            /* leading: CircleAvatar(
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/car4.png',
                    height: 28.0,
                    width: 25,
                  ),
                  borderRadius: BorderRadius.circular(60.0),
                ),
                backgroundColor: (model.carStatus.carStatus == "นำเข้า"
                    ? const Color(0xff89EB80)
                    : const Color(0xffEB8080))), */
            title: AutoSizeText(
              model.carChassis,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff404040),
                fontFamily: ('IBM Plex Sans Thai'),
                fontWeight: FontWeight.bold,
              ),
              maxFontSize: 10,
              minFontSize: 8,
              maxLines: 1,
            ),
            subtitle: AutoSizeText(
              'รถยนต์',
              style: TextStyle(
                color: Color(0xff404040),
                fontSize: 14,
                fontFamily: ('Bai Jamjuree'),
                fontWeight: FontWeight.w300,
              ),
              maxFontSize: 11,
              minFontSize: 9,
              maxLines: 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Divider(height: 1, color: Color(0xffEBEBEB)),
        )
      ],
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
