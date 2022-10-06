import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/ReqModel.dart';

class GetReqService{
  Future<List<ReqAPI>> getreq() async {
     SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/req'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var req = Req.fromJson(jsonDecode(response.body));
    return req.data;
  }

}