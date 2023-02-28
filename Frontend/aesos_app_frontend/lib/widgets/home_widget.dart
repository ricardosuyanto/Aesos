import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    //final containerSize = screenSize.height * 0.2;
    const svg = 'assets/chat_bubble.svg';
    return Container(
      //width: screenSize.width * 100,
      //height: containerSize,
      //padding: EdgeInsets.all(16.0),
      //color: Colors.blue,
      child: ListView(children: [
        SvgPicture.asset(svg, semanticsLabel: 'My SVG Picture'),
      ]),
    );
  }
}
