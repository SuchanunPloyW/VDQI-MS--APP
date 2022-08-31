import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/FindcarModel.dart';


class FindCarService {
  Future<List<Passenger>> getcar() async {
    var response = await http
        .get(Uri.parse('http://206.189.92.79/api/car')); //<==========you api
    var jobs = Car.fromJson(jsonDecode(response.body));

    return jobs.data;
  }
  
}