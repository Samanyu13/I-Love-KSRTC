import 'package:flutter/material.dart';

InputDecoration textFieldDecorator(String text) {
  return InputDecoration(
      labelText: text,
      labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)));
}