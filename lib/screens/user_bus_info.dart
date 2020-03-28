import 'package:I_Love_KSRTC/templates/detailed_bus_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBusInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  List data = ModalRoute.of(context).settings.arguments;

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
              prefs.remove('__UID');
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: Icon(Icons.phonelink_erase),
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              if (data.length == 0) {
                print('SHIT');                
              }
              return Card(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                color: Colors.green[100],
                child: detailCell(data[i], context),
              );
            }),
      ),
    );
  }
}