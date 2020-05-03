// import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location location;
  IO.Socket _socket;
  LatLng currentLocation;
  LocationData destinationLocation;

  // var _polyline = <LatLng>[
  //   LatLng(51.5, -0.09),
  //   LatLng(53.3498, -6.2603),
  //   LatLng(48.8566, 2.3522),
  // ];

  List _pointData;
  var _pointLen;
  var _routeID;

  List<Marker> _markers;
  // Marker srcM;

  Future getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _routeID = prefs.getString('__RID');
  }

  void getBusStopPoints() async {
    try {
      await getLocalData();

      var map = new Map<String, dynamic>();
      map['route_id'] = _routeID;

      String url = '/private/user/requestbus/getAllStopLocationsByID';
      var res = await postWithBodyOnly(map, url);
      if (res != null) {
        if (res.success) {
          _pointData = res.about['data'];
        }
      } else {
        print('Error addich machaane..!');
      }

      // print(_pointData);
    } catch (err) {
      print(err);
    }
  }

  void socketInit() {
    String url = Env.get().ip;
    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket']
    });
  }

  markerInit() {
    _markers = <Marker>[
      // //source
      // Marker(
      //   width: 80.0,
      //   height: 80.0,
      //   point: LatLng(51.5, -0.09),
      //   builder: (ctx) => Container(
      //       child: Icon(
      //     Icons.star,
      //     color: Colors.orange,
      //   )),
      // ),
      // //destination
      // Marker(
      //   width: 10.0,
      //   height: 10.0,
      //   point: LatLng(53.3498, -6.2603),
      //   builder: (ctx) => Container(
      //     child: Icon(
      //       Icons.check_circle,
      //       color: Colors.green,
      //     ),
      //   ),
      // ),
      //current
      Marker(
        width: 10.0,
        height: 10.0,
        point: LatLng(9.7679, 76.4907),
        builder: (ctx) => Container(
            child: Icon(
          Icons.location_on,
          color: Colors.redAccent,
        )),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    currentLocation = LatLng(9.7679, 76.4907);

    getBusStopPoints();

    socketInit();

    markerInit();

    _socket.on('connect', (_) {
      _socket.on('locData', (loc) {
        setState(() {
          currentLocation.latitude = loc['latitude'];
          currentLocation.longitude = loc['longitude'];
        });
        updatePinOnMap();
      });
    });
  }

/*
  void setSourceAndDestinationIcons() async {
    //set the icons
  }

  void setInitialLocations() async {
    //set the initial location
    currentLocation = await location.getLocation();

    //set destination
    destinationLocation = LocationData.fromMap({
      'latitude': _pointData[_pointLen - 1]['latitude'],
      'longitude': _pointData[_pointLen - 1]['longitude']
    });
  }
*/
  // userLocation = await location.getLocation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('This is a map that is showing $currentLocation.'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: currentLocation,
                  zoom: 15.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: CachedNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: _markers),
                  // PolylineLayerOptions(
                  //   polylines: [
                  //     Polyline(
                  //         points: _polyline,
                  //         strokeWidth: 2.0,
                  //         color: Colors.blueGrey),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatePinOnMap() async {
    //change the marker
    setState(() {
      var newPos = Marker(
        width: 80.0,
        height: 80.0,
        point: currentLocation,
        builder: (ctx) => Container(
            child: Icon(
          Icons.location_on,
          color: Colors.redAccent,
        )),
      );
      _markers[0] = newPos;
    });
  }
}
