import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/responsModel.dart';

class PostCarAPI {
  dynamic url = 'https://vdqi-db.toyotaparagon.com/api/';
  Future<ResponseModel> PostCar(
    String car_chassis,
    String car_status,
    String car_where,
    String car_position,
    String fullname,
    String lastname,
    String date,
    String time,
    String car_line,
    String sort,
  ) async {
    try {
      Map<String, String> data = {
        'car_chassis': car_chassis,
        'car_status': car_status,
        'car_where': car_where,
        'car_position': car_position,
        'fullname': fullname,
        'lastname': lastname,
        'date': date,
        'time': time,
        'car_line': car_line,
        'sort': sort,
      };
      var dataencode = jsonEncode(data);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var _authToken = localStorage.getString('token');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
      };
      if (_authToken != null) {
        url = Uri.parse("https://vdqi-db.toyotaparagon.com/api/car");
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
