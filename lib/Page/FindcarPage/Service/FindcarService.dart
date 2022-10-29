import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Service/Model/StationModel.dart';
import 'dart:io';
import '../../../Service/Model/CarDBModel.dart';
import '../Model/FindcarModel.dart';

class FindCarService {
  /*  String token = authToken(); */
  Future<List<CarDBAPI>> getcar() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/cardb/sort/1'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var car = CarDB.fromJson(jsonDecode(response.body));
    return car.data;
  }
}

Future<List<StationAPI>> getstation() async {
  //get token
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var _authToken = localStorage.getString('token');

  // response uri
  var response = await http.get(Uri.parse('http://206.189.92.79/api/station'), headers: {
    HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
  });

  // return value
  var car_station = Station.fromJson(jsonDecode(response.body));
  return car_station.data;
}
