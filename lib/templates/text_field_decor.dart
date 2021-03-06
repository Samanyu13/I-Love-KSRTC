import 'package:flutter/material.dart';

InputDecoration getInputFieldDecoration(String text) {
  return InputDecoration(
      labelText: text,
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)));
}
