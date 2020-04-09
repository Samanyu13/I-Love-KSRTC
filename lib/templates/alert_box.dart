import 'package:flutter/material.dart';

Future showAlertBox(BuildContext context, String title, String body) {
  return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text(title,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        content: new Text(
          body,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
      ));
}
