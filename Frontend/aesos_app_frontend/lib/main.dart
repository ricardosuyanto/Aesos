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
          body: SizedBox(
            width: 300,
            height: 29.2,
            child: Image.asset("assets/chat_bubble.jpg", fit: BoxFit.fitWidth),
          )),
    );
  }
}
