import 'package:flutter/material.dart';

class MyButton extends ElevatedButton {
  MyButton(String text,
      {BuildContext? context, String? navigate, VoidCallback? action})
      : super(
      child: Text(text),
      onPressed: (navigate != null) ? () {
        Navigator.of(context!).pushNamed(navigate);
      } : action,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        minimumSize: MaterialStateProperty.all(const Size(200, 40)),
      ));
}
