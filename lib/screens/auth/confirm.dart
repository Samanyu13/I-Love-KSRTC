import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:I_Love_KSRTC/templates/alert_box.dart';
import 'package:I_Love_KSRTC/templates/submit_button.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _otp = new TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text('CONFIRM'),
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                keyboardType: TextInputType.text,
                controller: _otp,
                decoration: getInputFieldDecoration('OTP'),
              ),
              SizedBox(height: 40.0),
              SubmitButton('VERIFY', () async {
                Navigator.pushNamed(context, '/loader');

                dynamic id = ModalRoute.of(context).settings.arguments;
                print(id['data']);
                DateTime _timestamp = new DateTime.now();
                // print(timestamp);
                var map = new Map<String, dynamic>();
                map['otp'] = _otp.text;
                map['timestamp'] = _timestamp.toIso8601String();
                map['id'] = id['data'].toString();
                String url = '/auth/user/verify';
                var res = await postWithBodyOnly(map, url);
                Navigator.of(context).pop();

                if (res != null) {
                  if (res.success) {
                    await showAlertBox(context, "SUCCESS :D",
                        'Press OK to move onto the LoginPage..!');

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login', (route) => false);
                  } else {
                    await showAlertBox(
                        context, "VERIFICATION FAILED", res.about['comment']);
                  }
                } else {
                  await showAlertBox(context, "CONNECTION FAILED",
                      "Could'nt connect to the server:/");
                }
              }),
            ],
          ),
        ));
  }
}
