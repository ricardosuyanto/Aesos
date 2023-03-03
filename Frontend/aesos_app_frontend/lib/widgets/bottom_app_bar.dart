import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is mobile'),
      ),
      bottomNavigationBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_a_photo_rounded),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.memory),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.verified_user_rounded),
          label: "",
        )
      ]),
    );
  }
}
