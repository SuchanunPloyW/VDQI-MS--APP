import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/responsModel.dart';

class PostcarDB{
  dynamic url = 'http://206.189.92.79/api/';
  Future<ResponseModel> CarDB(
    String car_chassis,
    String posit_id,
    String car_status,
    String person,
  
    String date,
    String time,
    String sort,
    String car_where,
  ) async {
    try {
      Map<String, String> data = {
        'car_chassis': car_chassis,
        'posit_id': posit_id,
        'car_status': car_status,
        'person': person,
        'date': date,
        'time': time,
        'sort': sort,
        'car_where': car_where,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
      };
      if (_authToken != null) {
        url = Uri.parse("http://206.189.92.79/api/cardb");
        await http.post(
          url,
          body: dataencode,
          headers: headers,
        );

        /* dynamic A = car_line;
        SharedPreferences localStorage =await SharedPreferences.getInstance();
        localStorage.setString('A', A);   */
      }

      /* print(jsonEncode(data)); */

      return ResponseModel(success: true);
    } catch (e) {
      return ResponseModel(success: false, message: e.toString());
    }
  }
}
