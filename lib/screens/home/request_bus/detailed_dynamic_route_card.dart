import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:I_Love_KSRTC/templates/busstop_list.dart';
import 'package:flutter/material.dart';

Column dynamicRouteDetailCell(var x, BuildContext context) {
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

                String url = '/private/user/getAllStopsByID';

                var res = await postWithBodyOnly(map, url);
                var data = res.about['data'];
                print(data);
                await showBusStopListPopup(context, data);
              },
              child: Icon(Icons.directions_bus),
            ),
          ],
        ))
  ]);
}

TextStyle detailCellTextStyle() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    // color: Colors.white
  );
}
