import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Page/FindcarPage/Model/responsModel.dart';

class PostReqAPI {
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
}
