import 'package:I_Love_KSRTC/templates/detailed_bus_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('ID');
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            
            child: Icon(Icons.phonelink_erase),
          )
        ],
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
