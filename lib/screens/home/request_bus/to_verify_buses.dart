import 'dart:convert';

import 'package:I_Love_KSRTC/templates/alert_box.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ToVerifyRequestBus extends StatefulWidget {
  @override
  _ToVerifyRequestBusState createState() => _ToVerifyRequestBusState();
}

class _ToVerifyRequestBusState extends State<ToVerifyRequestBus> {
  bool _loading = true;
  String _id, _token;
  var _data;

  void getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('__UID');
    _token = prefs.getString('USER_TOKEN');
  }

  void retrieveData(String _id) async {
    try {
      String url = Env.get().ip;
      url = url + 'here';
      print(url);
      var map = new Map<String, dynamic>();
      map['user_id'] = _id;
      http.Response response = await http.post(url, body: map, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'x-access-token': _token
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() => _loading = false);

        var res = json.decode(response.body);
        Response ret = Response.fromJSON(res);
        if (res.success) {
          _data = ret.about['data'];

          if (_data == null) {
            showAlertBox(context, 'MESSAGE',
                'Looks like you do not have any buses under verification..!');
          }
        } else {
          showAlertBox(context, 'ERROR', ret.about['comment']);
        }
      } else {
        showAlertBox(context, 'ERROR', 'Error fetching data..:/');
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();

    getLocalData();
    retrieveData(_id);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('CONFIRMED BUSES'),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('__UID');
              prefs.remove('__UNAME');
              prefs.remove('USER_TOKEN');

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: Icon(Icons.phonelink_erase),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start, children: showHomePage()),
    );
  }

  List<Widget> showHomePage() {
    return (_loading
        ? [
            Center(
              child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.greenAccent)),
            )
          ]
        : [
            SizedBox(height: 40.0),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[],
              ),
            ),
            SizedBox(height: 15.0),
          ]);
  }
}
