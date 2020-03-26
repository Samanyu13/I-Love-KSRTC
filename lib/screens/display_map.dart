import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

var points = <LatLng>[
  LatLng(51.5, -0.09),
  LatLng(53.3498, -6.2603),
  LatLng(48.8566, 2.3522),
];

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    //source
    var markers = <Marker>[
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
      appBar: AppBar(title: Text('Home')),
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
                  center: LatLng(51.5, -0.09),
                  zoom: 5.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: NetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: markers),
                  PolylineLayerOptions(
                    polylines: [
                      Polyline(
                          points: points,
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
}
