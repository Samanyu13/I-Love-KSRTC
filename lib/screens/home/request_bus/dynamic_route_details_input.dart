import 'package:I_Love_KSRTC/templates/submit_button.dart';
import 'package:I_Love_KSRTC/templates/text_field_decor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicRouteDetailsInput extends StatefulWidget {
  @override
  _DynamicRouteDetailsInputState createState() =>
      _DynamicRouteDetailsInputState();
}

class _DynamicRouteDetailsInputState extends State<DynamicRouteDetailsInput> {
  var _finaldate;
  var _date = "Date";
  final _timeFrame = new TextEditingController();
  final _count = new TextEditingController();

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      _finaldate = order;
      _date = DateFormat("dd/MM/yyyy").format(_finaldate);
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            accentColor: Colors.greenAccent,
            primaryColor: Colors.green,
          ),
          child: child,
        );
      },
    );
  }

  var _timeItems = [
    '6AM to 12PM (Morning)',
    '12PM to 6PM (Evening)',
    '6PM to 6AM (Night)',
  ];
  var _countItems = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print(data['route_id']);

    return Scaffold(
        appBar: AppBar(
          title: Text('Bus Details'),
          backgroundColor: Colors.green,
          actions: <Widget>[
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('__UID');
                prefs.remove('__UNAME');

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: Icon(Icons.phonelink_erase),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              TextField(
                enabled: false,
                decoration: getInputFieldDecoration(data['route_name']),
              ),
              SizedBox(
                height: 20,
              ),
              //***********************************************************************
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                    hintText: _finaldate == null ? "SELECT DATE" : "$_date",
                    hintStyle: getLabelStyle(),
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          callDatePicker();
                        }),
                    labelStyle: getLabelStyle(),
                    focusedBorder: getFocusedBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              //***********************************************************************
              //TIME FRAME
              TextField(
                readOnly: true,
                controller: _timeFrame,
                decoration: InputDecoration(
                    suffixIcon: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.green,
                      ),
                      onSelected: (String value) {
                        _timeFrame.text = value;
                      },
                      itemBuilder: (BuildContext context) {
                        return _timeItems
                            .map<PopupMenuItem<String>>((String value) {
                          return new PopupMenuItem(
                              child: new Text(
                                value,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500),
                              ),
                              value: value);
                        }).toList();
                      },
                    ),
                    labelText: 'TIME',
                    labelStyle: getLabelStyle(),
                    focusColor: Colors.green,
                    focusedBorder: getFocusedBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              //***********************************************************************
              //COUNT
              TextField(
                readOnly: true,
                controller: _count,
                decoration: InputDecoration(
                    suffixIcon: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.green,
                      ),
                      onSelected: (String value) {
                        _count.text = value;
                      },
                      itemBuilder: (BuildContext context) {
                        return _countItems
                            .map<PopupMenuItem<String>>((String value) {
                          return new PopupMenuItem(
                              child: new Text(
                                value,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500),
                              ),
                              value: value);
                        }).toList();
                      },
                    ),
                    labelText: 'COUNT',
                    labelStyle: getLabelStyle(),
                    focusColor: Colors.green,
                    focusedBorder: getFocusedBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              //***********************************************************************
              //BUTTON
              SubmitButton('SUBMIT', () async {
                var map = new Map<String, dynamic>();

                map['route_id'] = data['route_id'];
                map['date'] = _finaldate;
                map['count'] = _count.text;
                map['time_frame'] = _timeItems.indexOf(_timeFrame.text);

                print(map);
                // var res = await getRouteData(map);
              })
            ],
          ),
        ));
  }

  UnderlineInputBorder getFocusedBorder() {
    return UnderlineInputBorder(borderSide: BorderSide(color: Colors.green));
  }

  TextStyle getLabelStyle() {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      // color: Colors.black
    );
  }
}
