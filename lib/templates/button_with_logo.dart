import 'package:flutter/material.dart';

Container getButtonWithLogo(String text, IconData icon) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black, style: BorderStyle.solid, width: 1.0),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          // child: Image(
          // image: AssetImage('assets/images/gmail.png',),
          // ),
          child: Icon(icon),
        ),
        SizedBox(width: 10.0),
        Center(
          child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        )
      ],
    ),
  );
}
