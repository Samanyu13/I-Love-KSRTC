import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../widgets/drawer.dart';

class MapControllerPage extends StatefulWidget {
  static const String route = 'map_controller';

  @override
  MapControllerPageState createState() {
    return MapControllerPageState();
  }
}

class MapControllerPageState extends State<MapControllerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static LatLng sreekariyam = LatLng(27.2038, 76.9366);


  MapController mapController;
  double rotation = 0.0;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: sreekariyam,
        builder: (ctx) => Container(
          key: Key('blue'),
          child: FlutterLogo(),
        ),
      )
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('MapController')),
      drawer: buildDrawer(context, MapControllerPage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text('Sreekariyam'),
                    onPressed: () {
                      mapController.move(sreekariyam, 18.0);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text('Fit Bounds'),
                    onPressed: () {
                      var bounds = LatLngBounds();
                      bounds.extend(sreekariyam);
                      mapController.fitBounds(
                        bounds,
                        options: FitBoundsOptions(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        ),
                      );
                    },
                  ),
                  MaterialButton(
                    child: Text('Get Bounds'),
                    onPressed: () {
                      final bounds = mapController.bounds;

                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                          'Map bounds: \n'
                          'E: ${bounds.east} \n'
                          'N: ${bounds.north} \n'
                          'W: ${bounds.west} \n'
                          'S: ${bounds.south}',
                        ),
                      ));
                    },
                  ),
                  Text('Rotation:'),
                  Expanded(
                    child: Slider(
                      value: rotation,
                      min: 0.0,
                      max: 360,
                      onChanged: (degree) {
                        setState(() {
                          rotation = degree;
                        });
                        mapController.rotate(degree);
                      },
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(8.5241, 76.9366),
                  zoom: 5.0,
                  maxZoom: 5.0,
                  minZoom: 3.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c']),
                  MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
