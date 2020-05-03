import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:I_Love_KSRTC/templates/alert_box.dart';
import 'package:I_Love_KSRTC/templates/submit_button.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _email = new TextEditingController();
    TextEditingController _password = new TextEditingController();
    TextEditingController _mobileNo = new TextEditingController();
    TextEditingController _userName = new TextEditingController();

    return Scaffold(
      key: mykey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('SIGN UP')),
      body: ListView(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _userName,
                  decoration: getInputFieldDecoration('USERNAME'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: getInputFieldDecoration('EMAIL'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _password,
                  decoration: getInputFieldDecoration('PASSWORD'),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _mobileNo,
                  decoration: getInputFieldDecoration('MOBILE NUMBER'),
                ),
                SizedBox(height: 40.0),
                SubmitButton('SIGNUP', () async {
                  Navigator.pushNamed(context, '/loader');

                  var map = new Map<String, dynamic>();

                  // map['userName'] = _username.text;
                  // map['email'] = _email.text;
                  // map['password'] = _password.text;
                  // map['mobileNo'] = _mobileNo.text;
                  map['userName'] = "Soman";
                  map['email'] = "samanyu@cet.ac.in";
                  map['password'] = "12345678";
                  map['mobileNo'] = "8281812793";
                  String url = '/auth/user/register';
                  var res = await postWithBodyOnly(map, url);
                  Navigator.of(context).pop();

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
