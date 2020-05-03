import 'package:flutter/material.dart';

Future showAlertBox(BuildContext context, String title, String body) {
  Color _indic = Colors.black;
  if (title == 'SUCCESS') {
    _indic = Colors.green;
  } else if (title == 'CONFIRMATION') {
    _indic = Colors.orange;
  } else if (title == 'ERROR') {
    _indic = Colors.red;
  }
  return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text(title,
            style: TextStyle(
                color: _indic, fontWeight: FontWeight.bold, fontSize: 16)),
        content: new Text(
          body,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
