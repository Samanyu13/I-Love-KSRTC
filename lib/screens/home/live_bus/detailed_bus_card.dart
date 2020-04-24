import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:I_Love_KSRTC/templates/busstop_list.dart';
import 'package:flutter/material.dart';

Column busDetailCell(var x, BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        padding: new EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              x['bus_no'],
                              style: detailCellTextStyle(),
                            ),
                            //BUS MAKE
                            Text(
                              x['bus_make'],
                              style: detailCellTextStyle(),
                            ),
                            //ROUTE NAME
                            Text(
                              x['route_name'],
                              style: detailCellTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () async {
                            var map = new Map<String, dynamic>();
                            map['route_id'] = x['route_id'];

                            String url = '/private/user/getAllStopsByID';
                            var res = await postWithBodyOnly(map, url);
                            var data = res.about['data'];
                            await showBusStopListPopup(context, data);
                          },
                          child: Text(
                            "Bus Stops",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                decorationColor: Colors.black),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed('/maps', arguments: x['route_id']);
                          },
                          color: Colors.greenAccent,
                          child: Text(
                            "Live Location",
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.white),
                          ),
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      )
    ],
  );
}

TextStyle detailCellTextStyle() {
  return TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    // color: Colors.white
  );
}
