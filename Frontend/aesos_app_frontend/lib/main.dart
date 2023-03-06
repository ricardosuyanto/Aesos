import 'package:aesos_app_frontend/responsive/mobile_screen.dart';
import 'package:aesos_app_frontend/responsive/responsive_layout.dart';
import 'package:aesos_app_frontend/responsive/web_screen.dart';
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
      home: ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
