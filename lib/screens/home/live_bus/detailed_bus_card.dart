import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:I_Love_KSRTC/templates/busstop_list.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
                            style: TextStyle(decorationColor: Colors.black),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('__RID', x['route_id']);
                            socketInit("B" + x['route_id']);
                            Navigator.of(context)
                                .pushNamed('/maps', arguments: x['route_id']);
                          },
                          color: Colors.greenAccent,
                          child: Text(
                            "Live Location",
                            style: TextStyle(color: Colors.white),
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

void socketInit(String _roomID) {
  print(_roomID);
  String url = Env.get().ip;
  IO.Socket _socket = IO.io(url, <String, dynamic>{
    'transports': ['websocket']
  });
  _socket.on('connect', (_) {
    print('Inside Connection');
    _socket.emitWithAck('clientJoinsRoom', _roomID, ack: (data) {
      if (data != null) {
        print('from server $data');
      } else {
        print("Null");
      }
    });
  });
}

TextStyle detailCellTextStyle() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    // color: Colors.white
  );
}
