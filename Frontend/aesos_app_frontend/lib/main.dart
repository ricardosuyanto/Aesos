import 'package:aesos_app_frontend/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aesos',
      theme: ThemeData.dark(),
      home: SignupScreen(),
    );
  }
}
