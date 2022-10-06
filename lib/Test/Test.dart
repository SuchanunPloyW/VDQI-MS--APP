import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Page/FindcarPage/Model/FindcarModel.dart';
import '../Page/FindcarPage/Service/FindcarService.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        
         child: FutureBuilder <List<CarAPI>>(
          future: FindCarService().getcar(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return SingleChildScrollView(
               
                child: Container(
                  color: Colors.amber,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                          label: Text(
                            '',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      DataColumn(
                          label: Text(
                            '',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                  
                    ],
                    rows: snapShot.data!.map<DataRow>((e) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text('${e.carChassis}')),
                            DataCell(Text('${e.fullname}')),
                            
                          ],
                        );
                      }).toList(),
                  ),
                ),
              );
    
            }
            else{
              return CircularProgressIndicator();
            }
          }
          
           
    
         )
        
        
        
      ),
    );
  }
  Widget table({required CarAPI model}){
    return DataTable(
              columns: const <DataColumn>[
                DataColumn(
                label: Expanded(
                  child: Text(
                    'car',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),

              ],
              rows: <DataRow> [
                 DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(model.carChassis),),
                    DataCell(
                      Text(model.fullname),),
                      
                   
                  ],
                ),

              ],
              );
  }
}