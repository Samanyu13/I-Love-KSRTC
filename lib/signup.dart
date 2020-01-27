import 'dart:convert';

import 'package:I_Iove_KSRTC/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();
    TextEditingController mobileNo = new TextEditingController();
    TextEditingController firstName = new TextEditingController();
    TextEditingController lastName = new TextEditingController();
    TextEditingController userName = new TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Welcome',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            )),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                  child: Center(
                      child: Text('SIGNUP',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: firstName,
                  decoration: textFieldDecorator('FIRST NAME'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: lastName,
                  decoration: textFieldDecorator('LAST NAME'),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: userName,
                  decoration: textFieldDecorator('USERNAME'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: textFieldDecorator('EMAIL'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: password,
                  decoration: textFieldDecorator('PASSWORD'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: mobileNo,
                  decoration: textFieldDecorator('MOBILE NUMBER'),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: InkWell(
                      onTap: () async {
                        UserSignUp regRequest = new UserSignUp(
                            firstName: firstName.text,
                            lastName: lastName.text,
                            userName: userName.text,
                            email: email.text,
                            password: password.text,
                            mobileNo: mobileNo.text);

                        http.post('http://192.168.10.13:3000/auth/register', body: regRequest.toMap()).then((http.Response response) {
                          final int statusCode = response.statusCode;
                          print(response.body);
                          if(statusCode < 200 || statusCode > 400 || json == null) {
                            throw new Exception("Error while fetching data..!"); 
                          }
                          return UserSignUp.fromJson(json.decode(response.body));
                        });
                      },
                      child: Center(
                        child: Text('SIGNUP',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          )),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
