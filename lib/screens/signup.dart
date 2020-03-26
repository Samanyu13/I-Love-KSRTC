import 'dart:convert';

import 'package:I_Love_KSRTC/templates/buttons.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UserSignUp {
  final String userName;
  final String email;
  final String password;
  final String mobileNo;

  UserSignUp({this.userName, this.email, this.password, this.mobileNo});

  Map toMap() {
    var map = new Map<String, dynamic>();

    map['userName'] = userName;
    map['email'] = email;
    map['password'] = password;
    map['mobileNo'] = mobileNo;

    return map;
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();
    TextEditingController mobileNo = new TextEditingController();
    TextEditingController userName = new TextEditingController();

    return Scaffold(
      key: mykey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'SIGN UP',
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
            padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: userName,
                  decoration: getInputFieldDecoration('USERNAME'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: getInputFieldDecoration('EMAIL'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: password,
                  decoration: getInputFieldDecoration('PASSWORD'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: mobileNo,
                  decoration: getInputFieldDecoration('MOBILE NUMBER'),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: InkWell(
                      onTap: () async {
                        UserSignUp regRequest = new UserSignUp(
                            // userName: userName.text,
                            // email: email.text,
                            // password: password.text,
                            // mobileNo: mobileNo.text);

                            userName: "Soman",
                            email: "samanyu@cet.ac.in",
                            password: "12345678",
                            mobileNo: "8281812793");
                        var res = await registerPost(regRequest);

                        if (res != null) {
                          if (res.success) {
                            Navigator.of(context).pushNamed('/confirmpage',
                                arguments: res.about);
                          } else {
                            mykey.currentState.showSnackBar(SnackBar(
                              content: Text('Oops..!Something went wrong..:/'),
                              duration: Duration(seconds: 3),
                            ));
                            // Scaffold.of(context).showSnackBar(snackBar);
                          }
                        }
                      },
                      child: getColorButton('SIGNUP')),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> registerPost(UserSignUp regRequest) async {
  try {
    String url = Env.get().ip;
    url = url + '/auth/user/register';

    // print(url);
    http.Response response = await http.post(url, body: regRequest.toMap());
    final int statusCode = response.statusCode;
    // print(statusCode);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data..!");
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);
    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}
