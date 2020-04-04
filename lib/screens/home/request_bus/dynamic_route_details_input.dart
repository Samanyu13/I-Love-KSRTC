import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicRouteDetailsInput extends StatefulWidget {
  @override
  _DynamicRouteDetailsInputState createState() => _DynamicRouteDetailsInputState();
}

class _DynamicRouteDetailsInputState extends State<DynamicRouteDetailsInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bus Details'),
          backgroundColor: Colors.green,
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
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              TextField(
                enabled: false,
                // decoration: getInputFieldDecoration('HI'),
              ),
            ],
          ),
        ));
  }
}
