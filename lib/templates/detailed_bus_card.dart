import 'package:I_Love_KSRTC/screens/home/custom_busdetail_popup.dart';
import 'package:flutter/material.dart';

Column detailCell(var x, BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        // padding: new EdgeInsets.all(10.0),
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
                          onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomPopup(
                                      title: "BUS DETAILS",
                                      data: x,
                                    ))
                          },
                          child: Text(
                            "More details.",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                decorationColor: Colors.black),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/maps');
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
