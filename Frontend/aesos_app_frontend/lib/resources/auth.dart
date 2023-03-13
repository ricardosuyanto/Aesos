import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class AuthMethod {
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
}
