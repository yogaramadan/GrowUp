import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth{
    final String _url = 'https://growup.akutegar.com/api';

      var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token') ?? "")['token'];
  }

  // auth(data, apiURL) async {
  //   var fullUrl = _url + apiURL;
  //   return await Uri
  // }

  // getData(apiURL) async {
  //   var fullUrl = _url + apiURL;
  //   await _getToken();
  //   return await http.get(
  //     fullUrl,
  //     headers: _setHeaders(),
  //   );
  // }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

}