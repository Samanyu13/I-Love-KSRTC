class FromTo {
  String from;
  String to;

  FromTo(this.from, this.to);
}

class UserLogin {
  String mail;
  String password;

  UserLogin.getMail(this.mail);
  UserLogin.getBoth(this.mail, this.password);
}

class Response {
  dynamic about;
  int status;
  bool success;

  Response({this.about, this.status, this.success});

  factory Response.fromJSON(Map<String, dynamic> data) {
    return Response(
        about: data['about'], status: data['status'], success: data['success']);
  }
}

class BusStopName {
  String busstopName;

  BusStopName({this.busstopName});

  factory BusStopName.fromJSON(Map<String, dynamic> data) {
    return BusStopName(busstopName: data['busstop'] as String);
  }
}
