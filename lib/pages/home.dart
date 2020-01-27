import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class HomePage extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    //setting up the marker to display
    var marker = <Marker>[
      Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(8.5241, 76.9366),
        builder: (ctx) => Container(
          child: FlutterLogo(
            colors: Colors.blue,
            key: ObjectKey(Colors.blue),
          ),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
          title: Text('Let\'s Locate..!'), backgroundColor: Colors.green),
      // drawer: buildDrawer(context, route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('This is a map that is showing (8.5241, 76.9366).'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(8.5039, 76.9511),
                  zoom: 10.0,
                  interactive: true,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: NonCachingNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: marker)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
