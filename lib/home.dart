import 'package:flutter/material.dart';

import 'classes.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    final UserLogin loginArg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello ' + loginArg.mail,
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: 5,
            itemBuilder: (context, i) {
              return Card(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                color: Colors.green[100],
                child: DetailCell(i),
              );
            }),
      ),
    );
  }
}
