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

class BusData {
  String routeID;
  String routeName;
  String busNo;
  String regNo;
  String busMake;
  String empCode;
}
