import 'dart:convert';

import 'package:I_Love_KSRTC/templates/alert_box.dart';
import 'package:I_Love_KSRTC/templates/buttons.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfirmPage extends StatelessWidget {
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
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "Enter the otp sent to your mail-ID for confirming your registration..!",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: otp,
                decoration: getInputFieldDecoration('OTP'),
              ),
              SizedBox(height: 40.0),
              Container(
                height: 40.0,
                child: InkWell(
                  onTap: () async {
                    dynamic id = ModalRoute.of(context).settings.arguments;
                    print(id['data']);
                    id = id['data'];
                    print(id['data']);
                    DateTime timestamp = new DateTime.now();
                    // print(timestamp);
                    var map = new Map<String, dynamic>();
                    map['otp'] = otp.text;
                    map['timestamp'] = timestamp.toIso8601String();
                    map['id'] = id['data'].toString();
                    var res = await verifyPost(map);

                    if (res != null) {
                      if (res.success) {
                        await showAlertBox(context, "SUCCESS :D",
                            'Press OK to move onto the LoginPage..!');

                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/login', (route) => false);
                      } else {
                        await showAlertBox(context, "VERIFICATION FAILED",
                            res.about['comment']);
                      }
                    } else {
                      await showAlertBox(context, "CONNECTION FAILED",
                          "Could'nt connect to the server:/");
                    }
                  },
                  child: getColorButton('VERIFY'),
                ),
              ),
            ],
          ),
        ));
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
