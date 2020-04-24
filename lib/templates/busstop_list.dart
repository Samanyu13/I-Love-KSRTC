import 'package:flutter/material.dart';

Future showBusStopListPopup(BuildContext context, dynamic data) {
  return showDialog(
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
}

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
