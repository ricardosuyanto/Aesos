import 'package:aesos_app_frontend/widgets/home_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aesos',
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
          ),
          body: HomeWidget()),
    );
  }
}
