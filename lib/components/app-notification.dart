import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppNotification {
  final String message;

  AppNotification(this.message);

  void show(BuildContext context) {
    Flushbar(
      message: message,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      animationDuration: Duration(
        milliseconds: 500,
      ),
      duration: Duration(
        seconds: 2,
      ),
    )..show(context);
  }
}
