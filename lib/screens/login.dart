import 'dart:convert';

import 'package:I_Love_KSRTC/templates/app_drawer.dart';
import 'package:I_Love_KSRTC/templates/buttons.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();

  final mail = new TextEditingController();
  final password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: mykey,
      resizeToAvoidBottomPadding: false,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Hello'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                  child: Text('Hello',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(220.0, 45.0, 0.0, 0.0),
                  child: Text('.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: mail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: getInputFieldDecoration('EMAIL'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: password,
                  decoration: getInputFieldDecoration('PASSWORD'),
                  obscureText: true,
                ),
                SizedBox(height: 5.0),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/forgotpass');
                    },
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: InkWell(
                      onTap: () async {
                        var map = new Map<String, dynamic>();

                        map['password'] = password.text;
                        map['email'] = mail.text;
                        var res = await loginPost(map);

                        if (res != null) {
                          if (res.success) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var token = res.about['data'];
                            // print(token);
                            prefs.setString('USER_TOKEN', token);
                            prefs.setString('__UID', res.about['comment'].toString());
                            
                            Navigator.pushNamed(context, '/home',
                                arguments: UserLogin.getMail(mail.text));
                          }
                        } else {
                          mykey.currentState.showSnackBar(SnackBar(
                              content: Text('Login Failed..:/'),
                              duration: Duration(seconds: 3)));
                        }
                      },
                      child: getColorButton('LOGIN')),
                ),
                SizedBox(height: 20.0),
                Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {

                        Location location = new Location();

                        try {
                          LocationData currentLocation =
                              await location.getLocation();
                          print(currentLocation.latitude);
                          print(currentLocation.longitude);
                        } on Exception catch (e) {
                          print(e);
                        }
                      },
                      child: getButtonWithLogo(
                          'Login with GMail', Icons.mail_outline),
                    ))
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New to the community ?',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/signup');
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Future<dynamic> loginPost(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/auth/user/login';

    http.Response response = await http.post(url, body: map);
    final int statusCode = response.statusCode;
    print(statusCode);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data..!");
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);
    print(ret.success);
    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}
