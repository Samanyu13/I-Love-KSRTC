import 'dart:convert';

import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPage extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController otp = new TextEditingController();

    return Scaffold(
      key: mykey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('CONFIRM',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Enter the otp sent to your mail-ID for confirming your registration..!",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          TextField(
            keyboardType: TextInputType.text,
            controller: otp,
            decoration: textFieldDecorator('OTP'),
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
                  var id = ModalRoute.of(context).settings.arguments;
                  print(id);
                  DateTime timestamp = new DateTime.now();
                  print(timestamp);
                  var map = new Map<String, dynamic>();
                  map['otp'] = otp.text;
                  map['timestamp'] = timestamp.toIso8601String();
                  map['id'] = id.toString();
                  var res = await verifyPost(map);

                  if (res != null) {
                    if (res.success) {
                      mykey.currentState.showSnackBar(SnackBar(
                        content: Text('Verification successful..! WELCOME :)'),
                        duration: Duration(seconds: 3),
                      ));
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setInt('ID', id);
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/home', (route) => false);
                    } else {
                      // Navigator.pop(context);
                      mykey.currentState.showSnackBar(SnackBar(
                        content: Text(
                            'Oops..! Verification Failed..:/. Please try again...'),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  } else {
                    print("Trouble while loading post...!");
                  }
                },
                child: Center(
                  child: Text('VERIFY',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> verifyPost(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/auth/user/verify';

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
