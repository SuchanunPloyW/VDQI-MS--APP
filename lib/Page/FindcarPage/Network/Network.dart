/* 
import 'dart:convert';
import 'package:http/http.dart';
import '../Model/FindcarModel.dart' as http;

List<Car> Car (String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  List<Car> cars = list.map(model) => Car.fromJson(model).toList();
  
}
Future<List<Car>> fetchCar() async{
  final response = await http.get('http://206.189.92.79/api/car');

  
} */