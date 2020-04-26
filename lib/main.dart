import 'package:I_Love_KSRTC/screens/auth/confirm.dart';
import 'package:I_Love_KSRTC/screens/auth/forgot_password.dart';
import 'package:I_Love_KSRTC/screens/auth/login.dart';
import 'package:I_Love_KSRTC/screens/auth/signup.dart';
import 'package:I_Love_KSRTC/screens/home/home.dart';
import 'package:I_Love_KSRTC/screens/home/live_bus/display_map.dart';
import 'package:I_Love_KSRTC/screens/home/live_bus/user_bus_info.dart';
import 'package:I_Love_KSRTC/screens/home/request_bus/confirmed_request_buses.dart';
import 'package:I_Love_KSRTC/screens/home/request_bus/dynamic_route_details_input.dart';
import 'package:I_Love_KSRTC/screens/home/request_bus/dynamic_route_list.dart';
import 'package:I_Love_KSRTC/screens/home/request_bus/live_history_request_buses.dart';
import 'package:I_Love_KSRTC/screens/home/request_bus/processing_request_buses.dart';
import 'package:I_Love_KSRTC/screens/home/request_bus/request_bus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('__UID');
  print("IDDD");
  print(id);
  runApp(MaterialApp(
    home: id == null ? LoginPage() : UserHome(),
    // home: DynamicRouteDetailsInput(),
    // home: LoginPage(),
    // home: ConfirmPage(),
    // home: SignUp(),
    // home: id == null ? UserHome() : LoginPage(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/signup': (context) => new SignUp(),
      '/login': (context) => new LoginPage(),
      '/home': (context) => new UserHome(),
      '/businfo': (context) => new UserBusInfo(),
      '/forgotpass': (context) => new ForgotPassword(),
      '/maps': (context) => MapPage(),
      '/confirmpage': (context) => ConfirmPage(),
      '/requestbus': (context) => RequestBus(),
      '/dynamicroutelist': (context) => DynamicRouteList(),
      '/routedetailsinput': (context) => DynamicRouteDetailsInput(),
      '/processingRequestBuses': (context) => ProcessingRequestBus(),
      '/confirmedRequestBuses': (context) => ConfirmedRequestBus(),
      '/liveHistoryRequestBuses': (context) => LiveHistoryRequestBus(),
    },
  ));
}
