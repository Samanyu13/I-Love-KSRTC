import 'package:I_Love_KSRTC/templates/buttons.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  final fromStop = new TextEditingController();
  final toStop = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Hello'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40.0),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: fromStop,
                  decoration: getInputFieldDecoration('FROM'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: toStop,
                  decoration: getInputFieldDecoration('TO'),
                  obscureText: true,
                ),
                SizedBox(height: 25.0),
                //Button
                Container(
                  height: 40.0,
                  child: InkWell(
                    onTap: () async {
                      var map = new Map<String, dynamic>();

                      map['password'] = fromStop.text;
                      map['email'] = toStop.text;
                      var res = await getBusData(map);

                      if (res != null) {
                        if (res.success) {}
                      } else {}
                    },
                    child: getColorButton('GO'),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}

Future<dynamic> getBusData(Map<String, dynamic> map) async {
  try {} catch (err) {
    print(err);
    return null;
  }
}
