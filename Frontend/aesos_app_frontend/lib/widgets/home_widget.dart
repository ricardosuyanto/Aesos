import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final containerSize = screenSize.height * 0.2;
    const png = 'assets/chat_bubble.png';
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: screenSize.height * 0.1,
            alignment: Alignment.center,
            child: Image.asset('Heart.png'),
          ),
        ),
        Expanded(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: screenSize.height * 0.1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Home",
                style: TextStyle(fontFamily: 'Amiko', fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: screenSize.height * 0.1,
            alignment: Alignment.center,
            child: Image.asset('chat_bubble.png'),
          ),
        ),
      ],
    );
  }
}
