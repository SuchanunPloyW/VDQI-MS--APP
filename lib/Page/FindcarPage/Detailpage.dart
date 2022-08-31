import 'package:flutter/material.dart';

import 'Model/FindcarModel.dart';



class DetailPage extends StatefulWidget {
  const DetailPage({Key? key , required this.model}) : super(key: key);
  final Passenger model;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(child: Column(children: [
            Text(widget.model.carChassis),
            Text(widget.model.fullname)
      ],)),
    );
  }
}
