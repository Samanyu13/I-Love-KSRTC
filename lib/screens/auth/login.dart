import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:I_Love_KSRTC/templates/alert_box.dart';
import 'package:I_Love_KSRTC/templates/button_with_logo.dart';
import 'package:I_Love_KSRTC/templates/submit_button.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();

  final _mail = new TextEditingController();
  final _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: mykey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Icon(Icons.person)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //****************************************************************
          Expanded(
            flex: 3,
            child: Row(
              // child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                  child: Text('WELCOME',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                  child: Text('.',
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                )
              ],
            ),
            // ),
          ),

          //****************************************************************
          //Login
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _mail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: getInputFieldDecoration('EMAIL'),
                    ),
                  ),
                  // SizedBox(height: 20.0),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _password,
                      decoration: getInputFieldDecoration('PASSWORD'),
                      obscureText: true,
                    ),
                  ),
                  // SizedBox(height: 5.0),
                  //Forgot Password
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('/forgotpass');
                        },
                      ),
                    ),
                  ),

                  // SizedBox(height: 20.0),
                  //Login
                  Expanded(
                    flex: 3,
                    child: SubmitButton('LOGIN', () async {
                      Navigator.pushNamed(context, '/loader');

                      var map = new Map<String, dynamic>();

                      map['password'] = _password.text;
                      map['email'] = _mail.text;
                      String url = '/auth/user/login';
                      var res = await postWithBodyOnly(map, url);
                      Navigator.of(context).pop();

                      if (res != null) {
                        if (res.success) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var token = res.about['data']['token'];
                          var name = res.about['data']['name'];
                          // print(token);
                          prefs.setString('USER_TOKEN', token);
                          prefs.setString(
                              '__UID', res.about['comment'].toString());
                          prefs.setString('__UNAME', name);
                          Navigator.pushNamed(context, '/home',
                              arguments: name);
                        } else {
                          print(res.about);
                          await showAlertBox(context, "Unsucessful Login",
                              res.about['comment']);
                        }
                      } else {
                        await showAlertBox(context, "CONNECTION ERROR",
                            "Could'nt connect to the server..! Please try Again");
                      }
                    }),
                  ),

                  // SizedBox(height: 20.0),
                  //Login as Guest
                  Expanded(
                    flex: 2,
                    child: Container(
                        height: 35.0,
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            Navigator.pushNamed(context, '/home');
                          },
                          child: getButtonWithLogo(
                              'Login as Guest', Icons.accessibility),
                        )),
                  ),

                  // Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New to the community ?',
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),

          Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }
}
