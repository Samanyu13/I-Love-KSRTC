import 'dart:convert';

import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Column dynamicRouteDetailCell(var x, BuildContext context) {
  List<Widget> myStopList(var data) {
    List<Widget> datum = new List();
    for (var i = 0; i < data.length; i++) {
      datum.add(SizedBox(
        height: 5,
      ));
      datum.add(Text(
        data[i]['busstop'],
        style: TextStyle(
          fontFamily: 'Montserrat',
        ),
      ));
    }
    return datum;
  }

  return Column(children: <Widget>[
    Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            //ROUTE NAME
            Expanded(
              child: Text(
                x['route_name'],
                style: detailCellTextStyle(),
              ),
            ),
            //BUTTON
            OutlineButton(
              borderSide: BorderSide(color: Colors.blueGrey),
              onPressed: () async {
                print("Show all busStops?");

                var map = new Map<String, dynamic>();
                map['route_id'] = x['route_id'];

                var res = await getData(map);
                var data = res.about['data'];
                print(data);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.lightGreen,
                      contentPadding: EdgeInsets.only(left: 25, right: 25),
                      title: Center(
                        child: Text("BUS STOPS",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                      content: Container(
                        height: 200,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            children: myStopList(data),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          color: Colors.blueGrey,
                          child: Text('OK'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.directions_bus),
            ),
          ],
        ))
  ]);
}

TextStyle detailCellTextStyle() {
  return TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    // color: Colors.white
  );
}

Future<dynamic> getData(Map<String, dynamic> map) async {
  try {
    String url = Env.get().ip;
    url = url + '/private/user/getAllStopsByID';

    http.Response response = await http.post(url, body: map);
    final int statusCode = response.statusCode;
    print(statusCode);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data..!");
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);
    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}
