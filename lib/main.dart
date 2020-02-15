import 'package:I_Love_KSRTC/confirm.dart';
import 'package:I_Love_KSRTC/error.dart';
import 'package:I_Love_KSRTC/forgotPassword.dart';
import 'package:I_Love_KSRTC/home.dart';
import 'package:I_Love_KSRTC/login.dart';
import 'package:I_Love_KSRTC/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './pages/animated_map_controller.dart';
import './pages/circle.dart';
import './pages/esri.dart';
import './pages/home.dart';
import './pages/map_controller.dart';
import './pages/marker_anchor.dart';
import './pages/moving_markers.dart';
import './pages/offline_map.dart';
import './pages/offline_mbtiles_map.dart';
import './pages/on_tap.dart';
import './pages/overlay_image.dart';
import './pages/plugin_api.dart';
import './pages/plugin_scalebar.dart';
import './pages/plugin_zoombuttons.dart';
import './pages/polyline.dart';
import './pages/tap_to_add.dart';

// void main() => runApp(new MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getInt('ID');
  runApp(MaterialApp(
    home: id == null ? LoginPage() : UserHome(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/signup': (context) => new SignUp(),
      '/home': (context) => new UserHome(),
      '/forgotpass': (context) => new ForgotPassword(),
      '/maps': (context) => HomePage(),
      '/confirmpage': (context) => ConfirmPage(),
      '/error': (context) => ErrorPage(),
      TapToAddPage.route: (context) => TapToAddPage(),
      EsriPage.route: (context) => EsriPage(),
      PolylinePage.route: (context) => PolylinePage(),
      MapControllerPage.route: (context) => MapControllerPage(),
      AnimatedMapControllerPage.route: (context) => AnimatedMapControllerPage(),
      MarkerAnchorPage.route: (context) => MarkerAnchorPage(),
      PluginPage.route: (context) => PluginPage(),
      PluginScaleBar.route: (context) => PluginScaleBar(),
      PluginZoomButtons.route: (context) => PluginZoomButtons(),
      OfflineMapPage.route: (context) => OfflineMapPage(),
      OfflineMBTilesMapPage.route: (context) => OfflineMBTilesMapPage(),
      OnTapPage.route: (context) => OnTapPage(),
      MovingMarkersPage.route: (context) => MovingMarkersPage(),
      CirclePage.route: (context) => CirclePage(),
      OverlayImagePage.route: (context) => OverlayImagePage(),
    },
  ));
}
