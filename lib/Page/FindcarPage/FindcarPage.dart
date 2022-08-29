// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vdqims/Page/MenuPage/MenuPage.dart';
//import '../MenuPage/MenuPage.dart';

class FindcarPage extends StatefulWidget {
  @override
  const FindcarPage({Key? key}) : super(key: key);
  State<FindcarPage> createState() => _FindcarPageState();
}

class _FindcarPageState extends State<FindcarPage> {
  String qrCode = '';  
  TextEditingController chassisController = TextEditingController();

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
                  text: "ค้นหารถยนต์",
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
        body:
         SingleChildScrollView(
           child: Stack(
            children: <Widget>[
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
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextField(
                            controller: chassisController = TextEditingController(text: "$qrCode"),
                            decoration: InputDecoration(
                                fillColor: Color(0xff9F1E1E),
                                filled: true,
                                hintText: " เลขตัวถัง",
                                hintStyle: TextStyle(
                                    fontFamily: ('IBM Plex Sans Thai'),
                                    color: Color(0xffE24646)),
                                contentPadding:
                                    EdgeInsets.only(left: 15, right: 10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xffE24646),
                                ),
                                suffixIconColor: Colors.grey),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                wordSpacing: 1),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: SizedBox(
                            height: 55,
                            width: 55,
                            child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                color: Color(0xff9F1E1E),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.qr_code_scanner_sharp,
                                    color: Color(0xffE24646),
                                  ),
                                  onPressed: ()  => scanQRCode(),
         
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
              padding: const EdgeInsets.only( top: 40),
              child: SingleChildScrollView(
                child: Positioned(
                  top: 50,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10 ,top: 46),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              SizedBox(
                                  height: 550,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      margin:
                                          const EdgeInsets.only(left: 10, right: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      child: ListView.builder(
                                        itemCount: 20,
                                        itemBuilder: (_, index){
                                          return Card(
                                            child: ListTile(
                                              title: Text('MNTADFC56966FGTY'),
                                              leading: CircleAvatar(backgroundColor: Color(0xff89EB80),),
                                              subtitle: Text('Yaris Ativ 1.2 G'),
                                              ),
                                              );
                                              }
                                              )),
                                              )),
                                
                            const SizedBox(height: 15),
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
                ),
              ),
            )
                 ]),
         ));
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
