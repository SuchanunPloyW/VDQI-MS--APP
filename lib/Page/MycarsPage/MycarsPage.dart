// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vdqims/Page/CardetailPage/CardetailPage.dart';
import 'package:vdqims/Page/FindcarPage/FindcarPage.dart';

import '../FindcarPage/Model/FindcarModel.dart';
import '../FindcarPage/Service/FindcarService.dart';

class MycarsPage extends StatefulWidget {
  const MycarsPage({Key? key}) : super(key: key);

  @override
  State<MycarsPage> createState() => _MycarsPageState();
}

class _MycarsPageState extends State<MycarsPage> {
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
              text: const TextSpan(
                  text: "รถยนต์ของฉัน",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: ('IBM Plex Sans Thai'),
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\nMy Cars',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: ('IBM Plex Sans Thai'),
                      ),
                    ),
                  ])),
          leading: IconButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FindcarPage()));
              });
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_sharp,
              size: 30,
            ),
          ),
          backgroundColor: baseColor1,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
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
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Positioned(
                  top: 80,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height: 650,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FutureBuilder(
                                      future: MyCarService().getfullname(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<CarAPI>?>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          List<CarAPI>? data = snapshot.data;
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
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: baseColor1,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )),

                            const SizedBox(height: 10),
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

  Widget Listcar({required CarAPI model}) {
    return InkWell(
      onTap: () {
        /*  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CardetailPage(
                      model: model,
                    ))); */
      }, //<<<<<<<<<< push to new screen เช่น
      child: SizedBox(
        height: 100,
        width: 55,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            /* shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ), */
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
                model.carChassis,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: ('IBM Plex Sans Thai'),
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: const Text(
                'Yaris Ativ 1.2 G \nสถานที่ : VDQI',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: ('IBM Plex Sans Thai'),
                ),
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

/*  child: Card(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          child:  ListTile(
                                            leading: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: ClipRRect(
                                                        borderRadius:  BorderRadius.all(Radius.circular(1.0)),
                                                         child: Image.asset(
                                                          'assets/images/car3.png',
                                                          height: 60.0,
                                                          width: 60,
                                                        ),
                                                      ),
                                                    ),
                                            title: const Text(
                                              ' MR1234598745616CD',
                                              style: TextStyle(
                                                fontFamily: ('IBM Plex Sans Thai'),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                              ),
                                            ),
                      
                                            subtitle: const Text(
                                              ' Yaris Ativ 1.2 G ' + '\n' + ' สถานที่'+' :'+' VDQI Station',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: ('IBM Plex Sans Thai'),
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ), */
