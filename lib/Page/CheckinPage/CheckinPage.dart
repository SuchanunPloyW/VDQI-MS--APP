import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vdqims/Page/FindcarPage/Model/FindcarModel.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({Key? key, required  this.model}) : super(key: key);
  final String model;


  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        title: Text( widget.model
,
                  
              style: const TextStyle(
              fontFamily:
             ('IBM Plex Sans Thai'),
              fontWeight:
             FontWeight.bold,
                                                    ),
                                                  ),

      ),

    );
    
  }
}