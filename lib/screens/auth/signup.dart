import 'dart:convert';

import 'package:I_Love_KSRTC/templates/alert_box.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/submit_button.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
      body: ListView(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
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
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: mobileNo,
                  decoration: getInputFieldDecoration('MOBILE NUMBER'),
                ),
                SizedBox(height: 40.0),
                SubmitButton('SIGNUP', () async {
                  var map = new Map<String, dynamic>();

                  // map['userName'] = username.text;
                  // map['email'] = email.text;
                  // map['password'] = password.text;
                  // map['mobileNo'] = mobileNo.text;
                  map['userName'] = "Soman";
                  map['email'] = "samanyu@cet.ac.in";
                  map['password'] = "12345678";
                  map['mobileNo'] = "8281812793";

                  var res = await registerPost(map);

                  if (res != null) {
                    if (res.success) {
                      Navigator.of(context)
                          .pushNamed('/confirmpage', arguments: res.about);
                    } else {
                      if (res.status == 409) {
                        await showAlertBox(context, "ERROR",
                            res.about['comment'] + ' - ALREADY EXISTS..!');
                      }
                    }
                  }
                }),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> registerPost(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/auth/user/register';

    http.Response response = await http.post(url, body: map);
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
