import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String _text;
  final Function _function;

  SubmitButton(this._text, this._function);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 35.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.greenAccent,
            color: Colors.green,
            elevation: 7.0,
            child: InkWell(
              onTap: _function,
              child: Center(
                child: Text(
                  _text,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
