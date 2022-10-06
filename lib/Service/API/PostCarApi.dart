import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Page/FindcarPage/Model/responsModel.dart';

class PostCarAPI{
  dynamic url = 'http://206.189.92.79/api/';
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
    )async{
      try {
        Map<String, String> data = {
          'car_chassis' : car_chassis,
          'car_status' : car_status,
          'car_where' : car_where,
          'car_position' : car_position,
          'fullname' : fullname,
          'lastname' : lastname,
          'date' : date,
          'time' : time,
          'car_line' : car_line,

        };
        var dataencode = jsonEncode(data);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var _authToken = localStorage.getString('token');
        Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken'
        };
        if (_authToken != null) {
        url = Uri.parse("http://206.189.92.79/api/car");
        await http.post(
          url,
          body: dataencode,
          headers: headers,
        );
      }
      return ResponseModel(success: true);

      }catch (e) {
        return ResponseModel(success: false, message: e.toString());

      }
    }
}
