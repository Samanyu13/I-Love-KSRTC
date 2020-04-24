import 'dart:convert';

import 'package:I_Love_KSRTC/templates/env.dart';
import 'package:I_Love_KSRTC/templates/io_classes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> postWithBodyOnly(Map<String, dynamic> map, String tail) async {
  try {
    String url = Env.get().ip;
    url = url + tail;

    http.Response response = await http.post(url, body: map);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data..!");
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);
    return ret;
  } catch (err) {
    print(err);
    return null;
  }
}

Future<dynamic> postWithBodyAndHeader(
    Map<String, dynamic> map, String tail) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('USER_TOKEN');
    String url = Env.get().ip;
    url = url + tail;

    http.Response response = await http.post(url, body: map, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-access-token': _token
    });
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data..!");
    }
    var res = json.decode(response.body);
    Response ret = Response.fromJSON(res);
    return ret;
  } catch (err) {
    print('X');
    print(err);
    print('X');

    return null;
  }
}
