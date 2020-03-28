import 'dart:convert';

import 'package:I_Love_KSRTC/templates/buttons.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();

  final fromStop = new TextEditingController();
  final toStop = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Hello'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('ID');
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
                ),
                SizedBox(height: 25.0),
                //Button
                Container(
                  height: 40.0,
                  child: InkWell(
                    onTap: () async {
                      var map = new Map<String, dynamic>();

                      map['from'] = fromStop.text;
                      map['to'] = toStop.text;
                      var res = await getBusData(map);

                      if (res != null) {
                        if (res.success) {
                          var data = res.about['data'];
                          
                          Navigator.pushNamed(context, '/businfo',
                                arguments: data);
                        }
                      } else {
                        mykey.currentState.showSnackBar(SnackBar(
                            content: Text('Login Failed..:/'),
                            duration: Duration(seconds: 3)));
                      }
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
  try {
    String url = Env.get().ip;
    url = url + '/private/user/retrieveAllLiveRoutes';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('USER_TOKEN');
    http.Response response =
        await http.post(url, body: map, headers: {'x-access-token': token});
    final int statusCode = response.statusCode;
    print(statusCode);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception('Error while fetching data..!');
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);
    print(ret.about);
    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}
