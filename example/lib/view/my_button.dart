import 'package:flutter/material.dart';

class MyButton extends FlatButton {
  MyButton(String text,
      {BuildContext context, String navigate, VoidCallback action})
      : super(
          child: Text(text),
          onPressed: (navigate != null)
              ? () {
                  Navigator.of(context).pushNamed(navigate);
                }
              : action,
        );
}
