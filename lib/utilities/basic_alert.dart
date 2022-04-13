import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class BasicAlert extends Alert {
  BuildContext context;
  String title;
  String desc;

  BasicAlert(
      {@required this.context, @required this.desc, this.title = "Warning"});

  @override
  // TODO: implement style
  AlertStyle get style => AlertStyle(
        isButtonVisible: false,
        backgroundColor: Colors.white70,
        overlayColor: Color(0x30000000),
      );
}
