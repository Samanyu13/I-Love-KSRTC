import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerItem(icon: Icons.contacts, text: 'Contacts'),
          createDrawerItem(icon: Icons.event, text: 'Events')
        ],
      ),
    );
  }
}

Widget createDrawerHeader() {
  return DrawerHeader(

      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[700],Colors.green[400]],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        ),
          // image: DecorationImage(
          //     fit: BoxFit.fill,
          //     image:  AssetImage('path/to/header_background.png'))
          ),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Drawer Head",
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
