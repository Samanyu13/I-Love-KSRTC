import 'package:I_Love_KSRTC/screens/home/request_bus/detailed_dynamic_route_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicRouteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DETAILS',
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
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
      body: new Center(
        child: new ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              if (data.length == 0) {
                print('SHIT');
              }
              return InkWell(
                child: Card(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  color: Colors.green[100],
                  child: dynamicRouteDetailCell(data[i], context),
                ),
                onTap: () async {
                  print("Goto data entry");
                  Navigator.pushNamed(context, '/routedetailsinput',
                      arguments: data[i]);
                },
              );
            }),
      ),
    );
  }
}
