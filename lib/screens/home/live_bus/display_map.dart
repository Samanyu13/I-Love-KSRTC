// import 'package:I_Love_KSRTC/screens/home/data_getter/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
  Location location;

  LocationData currentLocation;
  LocationData destinationLocation;

  var _polyline = <LatLng>[
    LatLng(51.5, -0.09),
    LatLng(53.3498, -6.2603),
    LatLng(48.8566, 2.3522),
  ];

  List _pointData;
  var _pointLen;
  var _id;

  var _markers;
/*
  @override
  void initState() {
    super.initState();

    //Getting the sent id from the before-page
    Future.delayed(Duration.zero, () {
      setState(() {
        _id = ModalRoute.of(context).settings.arguments;
      });
    });

    getBusStopPoints(_id);

    location = new Location();
    location.onLocationChanged().listen((LocationData data) {
      currentLocation = data;
      updatePinOnMap();
    });

    setSourceAndDestinationIcons();

    setInitialLocations();
  }

  void getBusStopPoints(var _id) async {
    var map = new Map<String, dynamic>();
    map['route_id'] = _id;

    String url = '/private/user/requestbus/getAllStopLocationsByID';
    var res = await postWithBodyOnly(map, url);
    setState(() {
      _pointData = res.about['data'];
      _pointLen = _pointData.length;
    });
    print(_pointData);
  }

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
    LocationData data = ModalRoute.of(context).settings.arguments;
    print("XXX");
    print(data);
    _markers = <Marker>[
      //source
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(51.5, -0.09),
        builder: (ctx) => Container(
            child: Icon(
          Icons.star,
          color: Colors.orange,
        )),
      ),
      //destination
      Marker(
        width: 10.0,
        height: 10.0,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Container(
          child: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
        ),
      ),
      //current
      Marker(
        width: 10.0,
        height: 10.0,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Container(
            child: Icon(
          Icons.location_on,
          color: Colors.redAccent,
        )),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('This is a map that is showing (51.5, -0.9).'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(data.latitude, data.longitude),
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
                  PolylineLayerOptions(
                    polylines: [
                      Polyline(
                          points: _polyline,
                          strokeWidth: 2.0,
                          color: Colors.blueGrey),
                    ],
                  ),
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
  }
}