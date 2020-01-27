import 'package:flutter/material.dart';

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

class UserSignUp {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String mobileNo;

  UserSignUp(
      {this.firstName,
      this.lastName,
      this.userName,
      this.email,
      this.password,
      this.mobileNo});

  factory UserSignUp.fromJson(Map<String, dynamic> json) {
    return UserSignUp(
        email: json['email'],
        password: json['password'],
        mobileNo: json['mobileNo']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['mobileNo'] = mobileNo;

    return map;
  }
}

class DetailCell extends StatelessWidget {
  final i;
  DetailCell(this.i);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // padding: new EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Bus No: $i",
                            style: detailCellTextStyle(),
                          ),
                          Text(
                            "Bus Type: XXX",
                            style: detailCellTextStyle(),
                          ),
                          Text(
                            "ETA: 10:00 -> 12:00",
                            style: detailCellTextStyle(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: null,
                        child: Text(
                          "More details.",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              decorationColor: Colors.black),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/maps');
                        },
                        color: Colors.greenAccent,
                        child: Text(
                          "Live Location",
                          style: TextStyle(
                              fontFamily: 'Montserrat', color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

TextStyle detailCellTextStyle() {
  return TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    // color: Colors.white
  );
}
