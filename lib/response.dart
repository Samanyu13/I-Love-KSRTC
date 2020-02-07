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
