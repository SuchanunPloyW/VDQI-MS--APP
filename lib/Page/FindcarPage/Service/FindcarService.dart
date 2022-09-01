import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/FindcarModel.dart';


class FindCarService {
  Future<List<CarAPI>> getcar() async {
    var response = await http.get(Uri.parse('http://206.189.92.79/api/car'));   
    var car = Car.fromJson(jsonDecode(response.body));
    return car.data;
  }
  
}