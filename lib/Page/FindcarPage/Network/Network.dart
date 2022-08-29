import 'dart:async';
import 'package:http/http.dart';
class ApiproviderService {
  static const String _apiUrl = "http://206.189.92.79";
   static Future<Response> get(String url) async {
    var request = Request("get", Uri.https(_apiUrl, url));
   var response = await _send(request);

    return response;
  }

  static Future<Response> _send(BaseRequest request) async {
    /* SharedPreferences localStorage = await SharedPreferences.getInstance();
    String accessToken = "";
    String refreshToken = "";
    var tokenStorage = localStorage.get("token");
    if (tokenStorage != null) {
      var j = jsonDecode(tokenStorage.toString());
      Token token = Token.fromJson(j);
      accessToken = token.accesstoken;
    } */

    var headers = <String, String>{
      "content-type": "application/json; charset=utf-8",
      "Accept-Language": "th-TH",
      //'Authorization': 'Bearer $accessToken'
    };
    var client = Client();
    request.headers.addAll(headers);
    var response = await client.send(request);
    return await Response.fromStream(response);
  }
}