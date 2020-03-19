
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

  factory Response.fromJSON(Map<String, dynamic> parsedJSON) {
    return Response(
        about: parsedJSON['about'],
        status: parsedJSON['status'],
        success: parsedJSON['success']);
  }
}
