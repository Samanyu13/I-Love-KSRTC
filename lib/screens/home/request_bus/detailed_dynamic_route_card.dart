import 'package:flutter/material.dart';

Column dynamicRouteDetailCell(var x, BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        // padding: new EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            //ROUTE NAME
            Text(
              x['route_name'],
              style: detailCellTextStyle(),
            ),
            //BUTTON
            OutlineButton(
              onPressed: () {
                print("Show all busStops?");
              },
              child: Text(
                "More details.",
                style: TextStyle(
                    fontFamily: 'Montserrat', decorationColor: Colors.black),
              ),
            ),
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
