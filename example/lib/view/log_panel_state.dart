import 'package:flutter/material.dart';
import 'package:zjsdk_example/view/log_panel.dart';

class LogPanelState extends State<LogPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: SingleChildScrollView(
        child: Text(widget.str),
      ),
    );
  }

  void setText() {
    setState(() {});
  }
}
