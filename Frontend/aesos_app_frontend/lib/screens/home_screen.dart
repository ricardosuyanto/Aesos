import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> login() async {
    final storage = FlutterSecureStorage();
    String? userJson = await storage.read(key: 'user');
    print(userJson);
    if (userJson != null) {
      User user = User.fromJson(json.decode(userJson));
      print(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}
