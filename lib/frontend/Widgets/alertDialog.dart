import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onAlertButtonPressed(
    {BuildContext context,
    String title,
    String desc,
    AlertType type,
    String buttonText,
    Function onTap}) {
  Alert(context: context, type: type, title: title, desc: desc, buttons: [
    DialogButton(
      onPressed: onTap,
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    )
  ]).show();
}
