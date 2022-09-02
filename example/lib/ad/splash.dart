import 'package:flutter/material.dart';
import 'package:zjsdk_ext/zj_splash_ad_view.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/log_panel.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 开屏广告演示页面
class SplashPage extends StatelessWidget {
  final LogPanel _logPanel = LogPanel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; //宽度
    final height = MediaQuery.of(context).size.height - 80; //高度
    return Scaffold(
      appBar: AppBar(
        title: Text("开屏广告"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            ZjSplashAdView(
              posId: Constants.splashPosId,
              width: width,
              height: height,
              onZjAdLoaded: () {
                // 广告加载成功
                _logPanel.setText("ZjSplashAd.onZjAdLoad");
              },
              onZjAdShow: () {
                // 广告展示
                _logPanel.setText("ZjSplashAd.onZjAdShow");
              },
              onZjAdClicked: () {
                // 广告点击
                _logPanel.setText("ZjSplashAd.onZjAdClicked");
              },
              onZjAdClosed: () {
                // 广告结束
                _logPanel.setText("ZjSplashAd.onZjAdClosed");
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              onZjAdError: (int code, String message) {
                // 广告加载或渲染错误，需要收集错误码和错误信息用于排查定位排查
                print("ZjSplashAd.onZjAdError[$code-$message]");
                Fluttertoast.showToast(msg: "[$code-$message]");
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            Align(alignment: Alignment.bottomCenter, child: _logPanel),
          ],
        ),
      ),
    );
  }
}
