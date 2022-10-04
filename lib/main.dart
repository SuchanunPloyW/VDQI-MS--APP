import 'package:flutter/material.dart';
import 'package:vdqims/Page/AddnewcarPage/AddnewcarPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color baseColor1 = const Color(0xffE52628);
  Color baseColor2 = const Color(0xffA10002);
/*   bool _isLoggedIn = false; */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const AddnewcarPage(),
    );
  }
}
