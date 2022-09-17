import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vdqims/Page/FindcarPage/Model/responsModel.dart';

import 'Model/StationModel.dart';

class CallApi {
  dynamic url = 'http://206.189.92.79/api/';
  postData(data, apiUrl) async {
    var fullUrl = Uri.parse(url + apiUrl + await _getToken());
    return await http.post(fullUrl, body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = Uri.parse(url + apiUrl);
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

  Future<ResponseModel>postcar(
    String car_chassis,
    String fullname,
    String lastname,
    String req_date,
    String req_time,
    String car_position,
  String car_where,
    String car_status,
    String car_station
    )async{
      
    try{
      Map<String,String>data={
      'car_chassis' : car_chassis,
      'fullname' : fullname,
      'lastname' : lastname,
      'req_date' : req_date,
      'req_time' : req_time,
      'car_position' : car_position,
      'car_where' : car_where,
      'car_status' : car_status,
      'car_station' : car_station,
      };
      var dataencode = jsonEncode(data);
      
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var _authToken = localStorage.getString('token');
        Map<String,String> headers = {'Content-Type':'application/json','Authorization': 'Bearer $_authToken'};
        if(_authToken!= null){
        url = Uri.parse("http://206.189.92.79/api/req");
        await http.post(url,
        body: dataencode,

        headers: headers,
      
      );
      }
      


        return ResponseModel(success: true);
    }catch (e){
      return ResponseModel(success: false ,message:  e.toString());
    }

  }




}



