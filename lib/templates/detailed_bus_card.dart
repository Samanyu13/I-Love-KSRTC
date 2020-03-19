import 'package:flutter/material.dart';

class DetailCell extends StatelessWidget {
  final i;
  DetailCell(this.i);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // padding: new EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Bus No: $i",
                            style: detailCellTextStyle(),
                          ),
                          Text(
                            "Bus Type: XXX",
                            style: detailCellTextStyle(),
                          ),
                          Text(
                            "ETA: 10:00 -> 12:00",
                            style: detailCellTextStyle(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: null,
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
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

TextStyle detailCellTextStyle() {
  return TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    // color: Colors.white
  );
}
