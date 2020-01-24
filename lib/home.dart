import 'package:flutter/material.dart';

import 'classes.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  // var _isLoading = true;

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
            return new FlatButton(
              padding: new EdgeInsets.all(0.0),
              child: DetailCell(i),
              onPressed: () {
                print("Cell No. $i has been tapped..!");
              },
              splashColor: Colors.blueAccent,
            );
          }
        ),
      ),
    );
  }
}
