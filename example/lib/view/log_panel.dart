import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zjsdk_example/view/log_panel_state.dart';

class LogPanel extends StatefulWidget {
  String str = "";

  final LogPanelState state = LogPanelState();

  @override
  State<StatefulWidget> createState() => state;

  static String getTime() {
    DateTime now = DateTime.now();
    return "[${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}]: ";
  }

  void setText(String newText) {
    if (newText == "_clear") {
      str = "";
    } else {
      str = "$str\n${getTime()}$newText";
    }
    state.setText();
  }
}
