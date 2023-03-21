import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PostMethod {
  Future<http.Response?> makePost({
    required int user_id,
    required String title,
    required String description,
    required String picture,
  }) async {
    http.Response? response;
    try {
      final url = Uri.parse('http://localhost:8081/makePost');
      final headers = {
        "Access-Control-Allow-Origin": "*",
        "Content-type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      final json = jsonEncode({
        "user_id": user_id,
        "title": title,
        "description": description,
        "picture": picture
      });
      response = await http.post(url, headers: headers, body: json);
      return response;
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
}
