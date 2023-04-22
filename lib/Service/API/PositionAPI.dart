import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/PositDBModel.dart';

class PostionService {
  /*  Future<List<PositionAPI>> getpositionStockA() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(
        Uri.parse('https://vdqi-db.toyotaparagon.com/api/position/search/1/A'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
        });
    // return value
    var position = Position.fromJson(jsonDecode(response.body));
    return position.data;
  } */

  Future<List<PositDBAPI>> getpositionStockB() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('https://vdqi-db.toyotaparagon.com/api/posit/search/2/B'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var positDB = PositDB.fromJson(jsonDecode(response.body));
    return positDB.data;
  }

  Future<List<PositDBAPI>> getWhere1() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('https://vdqi-db.toyotaparagon.com/api/posit/where/1'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var positDB = PositDB.fromJson(jsonDecode(response.body));
    return positDB.data;
  }

  Future<List<PositDBAPI>> getWhere2() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('https://vdqi-db.toyotaparagon.com/api/posit/where/2'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var positDB = PositDB.fromJson(jsonDecode(response.body));
    return positDB.data;
  }

  Future<List<PositDBAPI>> getWhere3() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('https://vdqi-db.toyotaparagon.com/api/posit/where/3'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var positDB = PositDB.fromJson(jsonDecode(response.body));
    return positDB.data;
  }

  Future<List<PositDBAPI>> getWhere4() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('https://vdqi-db.toyotaparagon.com/api/posit/where/4'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var positDB = PositDB.fromJson(jsonDecode(response.body));
    return positDB.data;
  }
}
