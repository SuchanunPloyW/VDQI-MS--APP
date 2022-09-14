import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdqims/Service/Model/StationModel.dart';
import 'dart:io';
import '../Model/FindcarModel.dart';

class FindCarService {
  /*  String token = authToken(); */
  Future<List<CarAPI>> getcar() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');

    // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/car'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var car = Car.fromJson(jsonDecode(response.body));
    return car.data;
  }
}

class MyCarService {
  var fullname;
   @override
 /*   void initState() {
     _getUserInfo();
     
   } */
   

  /*  String token = authToken(); */
  Future<List<CarAPI>> getfullname() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');
    var fullname = localStorage.getString('user');
    print(fullname);

    // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/car/name/ploy'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    // return value
    var car = Car.fromJson(jsonDecode(response.body));
    return car.data;
  }
}






 Future<List<StationAPI>> getstation() async {
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');
     
    var fullname = localStorage.getString('');
    print(fullname);

    // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/station'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });
    
    // return value
    var car_station = Station.fromJson(jsonDecode(response.body));
    return car_station.data;
  }

