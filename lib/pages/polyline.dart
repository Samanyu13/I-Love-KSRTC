import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../widgets/drawer.dart';

class PolylinePage extends StatelessWidget {
  static const String route = 'polyline';

  @override
  Widget build(BuildContext context) {
    var points = <LatLng>[
      LatLng(8.5241, 76.9366),

    ];

    var pointsGradient = <LatLng>[
      LatLng(8.5241, 76.9366),

    ];

    return Scaffold(
      appBar: AppBar(title: Text('Polylines')),
      drawer: buildDrawer(context, PolylinePage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('Polylines'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(8.5241, 76.9366),
                  zoom: 5.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c']),
                  PolylineLayerOptions(
                    polylines: [
                      Polyline(
                          points: points,
                          strokeWidth: 4.0,
                          color: Colors.purple),
                    ],
                  ),
                  PolylineLayerOptions(
                    polylines: [
                      Polyline(
                        points: pointsGradient,
                        strokeWidth: 4.0,
                        gradientColors: [
                          Color(0xffE40203),
                          Color(0xffFEED00),
                          Color(0xff007E2D),
                        ],
                      ),
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
