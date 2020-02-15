import 'dart:convert';

import 'package:I_Love_KSRTC/classes.dart';
import 'package:I_Love_KSRTC/drawer.dart';
import 'package:I_Love_KSRTC/env.dart';
import 'package:I_Love_KSRTC/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

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
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                  ),
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
                            mykey.currentState.showSnackBar(SnackBar(
                                content: Text('Success..!'),
                                duration: Duration(seconds: 3)));
                          }
                        } else {
                          mykey.currentState.showSnackBar(SnackBar(
                              content: Text('Login Failed..:/'),
                              duration: Duration(seconds: 3)));
                        }

                        Navigator.pushNamed(context, '/home',
                            arguments: UserLogin.getMail(mail.text));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: Center(
                          child: Text('LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),
                      )),
                ),
                SizedBox(height: 20.0),
                Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        // LocationData currentLocation = new LocationData();

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
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              // child: Image(
                              // image: AssetImage('assets/images/gmail.png',),
                              // ),
                              child: Icon(Icons.mail_outline),
                            ),
                            SizedBox(width: 10.0),
                            Center(
                              child: Text('Log in with Gmail',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            )
                          ],
                        ),
                      ),
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
    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}
