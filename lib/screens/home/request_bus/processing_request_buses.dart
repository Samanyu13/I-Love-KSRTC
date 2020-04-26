import 'dart:convert';

import 'package:I_Love_KSRTC/templates/alert_box.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/request_bus_cards.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProcessingRequestBus extends StatefulWidget {
  @override
  _ProcessingRequestBusState createState() => _ProcessingRequestBusState();
}

class _ProcessingRequestBusState extends State<ProcessingRequestBus> {
  bool _loading = true;
  String _id, _token;
  List _data;

  Future getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('__UID');
    _token = prefs.getString('USER_TOKEN');
    print(_id);
  }

  void retrieveData() async {
    try {
      await getLocalData();

      String url = Env.get().ip;
      url = url + '/private/user/getProcessingByUserID';
      var map = new Map<String, dynamic>();
      map['user_id'] = _id;
      print(map);
      http.Response response = await http.post(url, body: map, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'x-access-token': _token
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() => _loading = false);

        var res = json.decode(response.body);
        Response ret = Response.fromJSON(res);
        if (ret.success) {
          _data = ret.about['data'];
          print(_data);

          if (_data.isEmpty) {
            showAlertBox(context, 'MESSAGE',
                'Looks like you do not have any under-processing buses..!');
          }
        } else {
          showAlertBox(context, 'ERROR', ret.about['comment']);
        }
      } else {
        showAlertBox(context, 'ERROR', 'Error fetching data..:/');
      }
    } catch (err) {
      print(err);
      print('Shit');
    }
  }

  @override
  void initState() {
    super.initState();

    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Under-Processing Buses',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        backgroundColor: Colors.green,
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
      body: Center(child: showHomePage()),
    );
  }

  Widget showHomePage() {
    return (_loading
        ? CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent))
        : ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, i) {
              return new Card(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                color: Colors.green[100],
                child: processingCard(context, _data[i]['route_name'],
                    _data[i]['date'], _data[i]['time_frame']),
              );
            }));
  }
}
