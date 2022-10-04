import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/PositionModel.dart';

class PostionService {
  Future<List<PositionAPI>> getpositionStockA() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/position/search/1/A'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var position = Position.fromJson(jsonDecode(response.body));
    return position.data;
  }

  Future<List<PositionAPI>> getpositionStockB() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/position/search/2/B'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var position = Position.fromJson(jsonDecode(response.body));
    return position.data;
  }
}
