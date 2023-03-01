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
            decoration: BoxDecoration(color: Colors.greenAccent),
            child: Image.asset('Heart.png'),
          ),
        ),
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: screenSize.height * 0.1,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Column(
                children: [
                  Text(
                    "Home",
                    style: TextStyle(fontFamily: 'Amiko'),
                    textAlign: TextAlign.center,
                  )
                ],
              )),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: screenSize.height * 0.1,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.blue),
            child: Image.asset('chat_bubble.png'),
          ),
        ),
      ],
    );
  }
}
