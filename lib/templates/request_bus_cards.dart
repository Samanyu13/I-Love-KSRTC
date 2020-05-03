import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> _timeItems = [
  '6AM to 12PM (Morning)',
  '12PM to 6PM (Evening)',
  '6PM to 6AM (Night)',
];
String formatTime(String time) {
  var x = time.split(RegExp(r":"));
  int h = int.parse(x[0]);
  int m = int.parse(x[1]);
  String ap;
  if (h < 12) {
    ap = 'AM';
  } else {
    ap = 'PM';
  }
  h = h % 12;

  if (h == 0) {
    h = 12;
  }
  return (h.toString() + ':' + m.toString() + ':00 ' + ap);
}

String formatDate(String date) {
  return DateFormat("dd-MM-yyyy").format(DateTime.parse(date));
}

Column processingCard(
    BuildContext context, String routeName, String date, int timeFrame) {
  return Column(
    children: <Widget>[
      Container(
        padding: new EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 14,
            ),
            Text(routeName),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Expanded(
                  child: Icon(Icons.date_range),
                  flex: 1,
                ),
                Expanded(
                  child: Text(formatDate(date)),
                  flex: 3,
                ),
                Expanded(
                  child: Icon(Icons.timer),
                  flex: 1,
                ),
                Expanded(
                  child: Text(_timeItems[timeFrame]),
                  flex: 5,
                ),
              ],
            ),
            SizedBox(
              height: 14,
            )
          ],
        ),
      )
    ],
  );
}

Column confirmedCard(
    BuildContext context, String routeName, String date, String time) {
  return Column(
    children: <Widget>[
      Container(
        padding: new EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 14,
            ),
            Text(routeName),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Expanded(
                  child: Icon(Icons.date_range),
                  flex: 1,
                ),
                Expanded(
                  child: Text(formatDate(date)),
                  flex: 5,
                ),
                Expanded(
                  child: Icon(Icons.timer),
                  flex: 1,
                ),
                Expanded(
                  child: Text(formatTime(time)),
                  flex: 5,
                ),
              ],
            ),
            SizedBox(
              height: 14,
            )
          ],
        ),
      )
    ],
  );
}

TextStyle detailCellTextStyle() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    // color: Colors.white
  );
}
