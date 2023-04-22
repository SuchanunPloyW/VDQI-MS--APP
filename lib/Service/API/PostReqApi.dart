import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/responsModel.dart';

/* class PostReqAPI {
  dynamic url = 'http://206.189.92.79/api/';
  Future<ResponseModel> PostReq(
      String car_chassis,
      String fullname,
      String lastname,
      String req_date,
      String req_time,
      String car_position,
      String car_where,
      String car_status,
      String car_station,
      String car_line
      
      ) async {
    try {
      Map<String, String> data = {
        'car_chassis': car_chassis,
        'fullname': fullname,
        'lastname': lastname,
        'req_date': req_date,
        'req_time': req_time,
        'car_position': car_position,
        'car_where': car_where,
        'car_status': car_status,
        'car_station': car_station,
        'car_line': car_line,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
      };
      if (_authToken != null) {
        url = Uri.parse("http://206.189.92.79/api/req");
        await http.post(
          url,
          body: dataencode,
          headers: headers,
        );
      }
      return ResponseModel(success: true);
    } catch (e) {
      return ResponseModel(success: false, message: e.toString());
    }
  }
} */

// New API
class ReqAPIDB {
  dynamic url = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> PostReq(
    int car_id,
    String req_date,
    String req_time,
    String person,
  ) async {
    try {
      Map<String, String> data = {
        'car_id': car_id.toString(),
        'req_date': req_date,
        'req_time': req_time,
        'person': person,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'};
      if (_authToken != null) {
        url = Uri.parse("https://vdqi-db.toyotaparagon.com/api/reqDB");
        await http.post(
          url,
          body: dataencode,
          headers: headers,
        );
      }
      return ResponseModel(success: true);
    } catch (e) {
      return ResponseModel(success: false, message: e.toString());
    }
  }
}

class HistoryPost {
  dynamic url = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> PostHis(
      int car_id, String date, String time, String car_where, String car_status, String person) async {
    try {
      Map<String, String> data = {
        'car_id': car_id.toString(),
        'date': date,
        'time': time,
        'car_where': car_where,
        'car_status': car_status,
        'person': person,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $_authToken'};
      if (_authToken != null) {
        url = Uri.parse("https://vdqi-db.toyotaparagon.com/api/history");
        await http.post(
          url,
          body: dataencode,
          headers: headers,
        );
      }
      return ResponseModel(success: true);
    } catch (e) {
      return ResponseModel(success: false, message: e.toString());
    }
  }
}
