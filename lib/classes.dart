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
  String username;
  String password;
}

class DetailCell extends StatelessWidget {
  final i;
  DetailCell(this.i);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: new EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(
                  'assets/images/bl.jpg',
                ),
              ),
              Text('Text No. $i'),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
