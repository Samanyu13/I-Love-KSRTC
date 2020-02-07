import 'package:I_Love_KSRTC/widgets.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController otp = new TextEditingController();

    return Scaffold(
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
                fontFamily: 'Montserrat', fontWeight: FontWeight.bold, ),
          ),
          SizedBox(height: 10.0),
          TextField(
            keyboardType: TextInputType.text,
            controller: otp,
            decoration: textFieldDecorator('OTP'),
          ),
        ],
      ),
    );
  }
}
