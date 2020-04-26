import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var _id;

  void getMyID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('__UID');
  }

  @override
  void initState() {
    super.initState();

    getMyID();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader("Header"),
          //******************************REQUEST BUS******************************
          createDrawerItem(
              icon: Icons.directions_bus,
              text: 'Request A Bus',
              onTap: () {
                if (_id == null) {
                  youShouldLogin(context);
                } else {
                  Navigator.of(context).pushNamed('/requestbus');
                }
              }),
          //******************************REQUESTED BUSES******************************
          createDrawerItem(
              icon: Icons.priority_high,
              text: 'Under-Processing Requests',
              onTap: () {
                if (_id == null) {
                  youShouldLogin(context);
                } else {
                  Navigator.of(context).pushNamed('/processingRequestBuses');
                }
              }),
          //******************************CONFIRMED REQUESTED BUSES******************************
          createDrawerItem(
              icon: Icons.check,
              text: 'Confirmed Buses',
              onTap: () {
                if (_id == null) {
                  youShouldLogin(context);
                } else {
                  Navigator.of(context).pushNamed('/confirmedRequestBuses');
                }
              }),
          createDrawerItem(
              icon: Icons.history,
              text: 'Bus Requests Live History',
              onTap: () {
                if (_id == null) {
                  youShouldLogin(context);
                } else {
                  Navigator.of(context).pushNamed('/liveHistoryRequestBuses');
                }
              }),
          createDrawerItem(
              icon: Icons.phonelink_erase,
              text: 'Logout',
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('__UID');
                prefs.remove('__UNAME');

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              })
        ],
      ),
    );
  }
}

Future youShouldLogin(BuildContext context) {
  return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('ERROR',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 16)),
        content: new Text(
          'You have to login to use this functionality..:D',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('LOGIN'),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ));
}

Widget createDrawerHeader(String text) {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green[700], Colors.green[400]],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/lights.jpg'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

Widget createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
