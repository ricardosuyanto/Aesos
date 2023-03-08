import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class AuthMethod {
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? file,
  }) async {
    http.Response? response;
    try {
      final url = Uri.parse('http://localhost:8080/registerUser');
      final headers = {
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      final json = jsonEncode(
          {"email": email, "password": password, "username": username});
      final response = await http.post(url, headers: headers, body: json);

      print(response.statusCode);
      print(response.body);
    } catch (e) {
      log(e.toString());
    }
  }
}
