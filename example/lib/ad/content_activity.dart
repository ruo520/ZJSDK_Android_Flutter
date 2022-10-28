import 'package:flutter/material.dart';
import 'package:zjsdk/zj_sdk.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/my_button.dart';

/// 原生视频内容演示页面
class ContentActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("原生视频内容"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyButton("加载原生视频内容广告", action: () {
              ZjSdk.loadContentVideo(Constants.contentVideoPosId);
            }),
          ],
        ),
      ),
    );
  }
}
