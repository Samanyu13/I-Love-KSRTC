import 'package:I_Love_KSRTC/screens/confirm.dart';
import 'package:I_Love_KSRTC/screens/display_map.dart';
import 'package:I_Love_KSRTC/screens/error.dart';
import 'package:I_Love_KSRTC/screens/forgot_password.dart';
import 'package:I_Love_KSRTC/screens/home.dart';
import 'package:I_Love_KSRTC/screens/login.dart';
import 'package:I_Love_KSRTC/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getInt('ID');
  runApp(MaterialApp(
    // home: id == null ? LoginPage() : UserHome(),
    home: id == null ? UserHome() : LoginPage(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/signup': (context) => new SignUp(),
      '/login': (context) => new LoginPage(),
      '/home': (context) => new UserHome(),
      '/forgotpass': (context) => new ForgotPassword(),
      '/maps': (context) => MapPage(),
      '/confirmpage': (context) => ConfirmPage(),
      '/error': (context) => ErrorPage(),
    },
  ));
}
