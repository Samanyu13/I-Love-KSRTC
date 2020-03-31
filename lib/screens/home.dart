import 'dart:convert';

import 'package:I_Love_KSRTC/templates/buttons.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatefulWidget {
  UserHome() : super();

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool loading = true;
  AutoCompleteTextField searchTextField;
  GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();

  GlobalKey<AutoCompleteTextFieldState<BusStopName>> fKey = new GlobalKey();
  final fromStop = new TextEditingController();
  final toStop = new TextEditingController();

  static List<BusStopName> stopNames = List<BusStopName>();

  void getBusStops() async {
    try {
      String url = Env.get().ip;
      url = url + '/private/user/getAllBusNames';
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        stopNames = loadNames(response.body);
        print("XXX");
        // print(stopNames[0].busstopName);
        print(stopNames);
        print("XXX");

        setState(() {
          loading = false;
        });
      } else {
        print("Error getting the users..! :/");
      }
    } catch (err) {
      print(err);
    }
  }

  static List<BusStopName> loadNames(String jsonString) {
    final parsed = json.decode(jsonString);
    final p = parsed['about']['data'];
    // print(p);
    final data = p.cast<Map<String, dynamic>>();
    print(data);
    return data.map<BusStopName>((json) => BusStopName.fromJSON(json)).toList();
  }

  @override
  void initState() {
    getBusStops();

    super.initState();
  }

  Widget row(BusStopName name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          name.busstopName,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(width: 10),
      ],
    );
  }

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
              prefs.remove('__UID');
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
          children: showHomePage()),
    );
  }

  List<Widget> showHomePage() {
    return [
      SizedBox(height: 40.0),
      Container(
        padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            // TextFormField(
            //   controller: fromStop,
            //   decoration: getInputFieldDecoration('FROM'),
            // ),
            searchTextField = AutoCompleteTextField<BusStopName>(
              textCapitalization: TextCapitalization.characters,
              suggestionsAmount: 3,
              controller: fromStop,
              key: fKey,
              clearOnSubmit: false,
              suggestions: stopNames,
              decoration: getInputFieldDecoration('FROM'),
              itemFilter: (item, query) {
                return item.busstopName
                    .toLowerCase()
                    .startsWith(query.toLowerCase());
              },
              itemSorter: (a, b) {
                return a.busstopName.compareTo(b.busstopName);
              },
              itemSubmitted: (item) {
                setState(() {
                  searchTextField.textField.controller.text = item.busstopName;
                });
              },
              itemBuilder: (context, item) {
                //UI for the autocomplete row
                return row(item);
              },
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

                      Navigator.pushNamed(context, '/businfo', arguments: data);
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
    ];
  }
}

Future<dynamic> getBusData(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/private/user/retrieveAllLiveRoutes';
    http.Response response = await http.post(url, body: map);
    final int statusCode = response.statusCode;
    print(statusCode);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception('Error while fetching data..!');
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);
    print(ret.about);
    print(ret.status);
    print(ret.success);

    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}
