import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../Model/FindcarModel.dart';


class FindCarService {


 /*  String token = authToken(); */
  Future<List<CarAPI>> getcar() async {
    
    //get token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _authToken = localStorage.getString('token');  
    
   // response uri
    var response = await http.get(Uri.parse('http://206.189.92.79/api/car'),
    headers: {
       HttpHeaders.authorizationHeader: 'Bearer ${_authToken}',
    });  
    // return value
    var car = Car.fromJson(jsonDecode(response.body));
    return car.data;
  }


 
  
}