import 'dart:convert';

import 'package:I_Love_KSRTC/templates/alert_box.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:I_Love_KSRTC/templates/submit_button.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RequestBus extends StatefulWidget {
  @override
  _RequestBusState createState() => _RequestBusState();
}

class _RequestBusState extends State<RequestBus> {
  GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();

  AutoCompleteTextField searchTextFieldA;
  AutoCompleteTextField searchTextFieldB;

  GlobalKey<AutoCompleteTextFieldState<BusStopName>> fKeyA = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<BusStopName>> fKeyB = new GlobalKey();

  bool loading = true;

  final fromStop = new TextEditingController();
  final toStop = new TextEditingController();

  static List<BusStopName> stopNames = List<BusStopName>();

  void getBusStops() async {
    try {
      String url = Env.get().ip;
      url = url + '/private/user/getAllBusNames';
      print(url);
      http.Response response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        stopNames = loadNames(response.body);
        print(stopNames);

        setState(() => loading = false);
      } else {
        print("Error getting the users..! :/");
      }
    } catch (err) {
      print(err);
    }
  }

  static List<BusStopName> loadNames(String jsonString) {
    final parsed =
        json.decode(jsonString)['about']['data'].cast<Map<String, dynamic>>();
    print(parsed);
    return parsed
        .map<BusStopName>((json) => BusStopName.fromJSON(json))
        .toList();
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
        SizedBox(width: 5),
        Text(
          name.busstopName,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey),
        ),
        // SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // var username = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('REQUEST BUS'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('__UID');
              prefs.remove('__UNAME');

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
    return (loading
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
                children: <Widget>[
                  searchTextFieldA = AutoCompleteTextField<BusStopName>(
                    textCapitalization: TextCapitalization.characters,
                    suggestionsAmount: 5,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    controller: fromStop,
                    key: fKeyA,
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
                      setState(() => searchTextFieldA
                          .textField.controller.text = item.busstopName);
                    },
                    itemBuilder: (context, item) {
                      //UI for the autocomplete row
                      return row(item);
                    },
                  ),

                  SizedBox(height: 20.0),
                  searchTextFieldB = AutoCompleteTextField<BusStopName>(
                    textCapitalization: TextCapitalization.characters,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    suggestionsAmount: 5,
                    controller: toStop,
                    key: fKeyB,
                    clearOnSubmit: false,
                    suggestions: stopNames,
                    decoration: getInputFieldDecoration('TO'),
                    itemFilter: (item, query) {
                      return item.busstopName
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.busstopName.compareTo(b.busstopName);
                    },
                    itemSubmitted: (item) {
                      setState(() => searchTextFieldB
                          .textField.controller.text = item.busstopName);
                    },
                    itemBuilder: (context, item) {
                      //UI for the autocomplete row
                      return row(item);
                    },
                  ),
                  SizedBox(height: 25.0),
                  //Button
                  SubmitButton('GO', () async {
                    var map = new Map<String, dynamic>();

                    map['from'] = fromStop.text;
                    map['to'] = toStop.text;
                    var res = await getRouteData(map);

                    if (res != null) {
                      var data = res.about['data'];
                      print(data);
                      if (res.success && !data.isEmpty) {
                        Navigator.pushNamed(context, '/dynamicroutelist',
                            arguments: data);
                      } else if (res.success && data.isEmpty) {
                        await showAlertBox(context, "No Routes",
                            "Looks like no such direct routes found :/");
                      }
                    } else {
                      await showAlertBox(
                          context, "ERROR", "Something went wrong :/");
                    }
                  }),

                  SizedBox(height: 20.0),
                ],
              ),
            ),
            SizedBox(height: 15.0),
          ]);
  }
}

Future<dynamic> getRouteData(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/private/user/retrieveAllRoutes';
    http.Response response = await http.post(url, body: map);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception('Error while fetching data..!');
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);

    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}
