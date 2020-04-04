import 'package:flutter/material.dart';

class CustomBusDetailPopup extends StatelessWidget {
  final String title;
  final data;

  CustomBusDetailPopup({
    @required this.title,
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, title, data),
    );
  }
}

dialogContent(BuildContext context, String title, var data) {
  return Stack(
    children: <Widget>[
      cardPart(context, title, data),
      circularPart(),
    ],
  );
}

Container cardPart(BuildContext context, String title, var data) {
  return Container(
    padding: EdgeInsets.only(
      top: Consts.avatarRadius + Consts.padding,
      bottom: Consts.padding,
      left: Consts.padding,
      right: Consts.padding,
    ),
    margin: EdgeInsets.only(top: Consts.avatarRadius),
    decoration: new BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(Consts.padding),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          data['bus_no'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          data['route_name'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 6.0),
        Align(
          alignment: Alignment.bottomRight,
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).pop(); // To close the dialog
            },
            child: Text("OK"),
          ),
        ),
      ],
    ),
  );
}

Positioned circularPart() {
  return Positioned(
    left: Consts.padding,
    right: Consts.padding,
    child: CircleAvatar(
      backgroundColor: Colors.lightGreen,
      radius: Consts.avatarRadius,
      child: Icon(Icons.directions_bus,
      color: Colors.blue,
      size: Consts.avatarRadius,),
    ),
  );
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
