import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthMethod {
  final storage = FlutterSecureStorage();
  //sign up
  Future<http.Response?> signUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? file,
  }) async {
    http.Response? response;
    try {
      final url = Uri.parse('http://localhost:8081/registerUser');
      final headers = {
        "Access-Control-Allow-Origin": "*",
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      final json = jsonEncode(
          {"email": email, "password": password, "username": username});
      response = await http.post(url, headers: headers, body: json);
      return response;
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  //logging in
  Future<http.Response?> login({
    required String username,
    required String password,
  }) async {
    http.Response? response;
    try {
      final url = Uri.parse('http://localhost:8081/login');
      final headers = {
        "Access-Control-Allow-Origin": "*",
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      final json = jsonEncode({"username": username, "password": password});
      response = await http.post(url, headers: headers, body: json);
      return response;
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  /*Future<model.User> getUserDetails() async {
    
    return model.User.fromJson(json as Map<String, dynamic>);
  }*/
}
