import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/Model/User1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  Future<bool> register(String email, String username, String pass) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/login/register');
    http.Response response = await http.post(uri, body: {
      'email': email,
      'username': username,
      'pass': pass,
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return false;
  }

  Future<dynamic> login(String email, String pass) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/login/');
    http.Response response =
        await http.post(uri, body: {'email': email, 'pass': pass});
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      if (map['status']) {
        User1 user1 = User1.fromMap(map['data']);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', user1.token);
        return user1;
      }
    }
    return false;
  }

  Future<dynamic> checkToken() async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/login/token');

    String? token = await getToken();

    if (token != null) {
      http.Response response = await http.post(uri, body: {'token': token});
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status']) {
          User1 user1 = User1.fromMap(map['data']);
          return user1;
        }
      }
    }
    return false;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
