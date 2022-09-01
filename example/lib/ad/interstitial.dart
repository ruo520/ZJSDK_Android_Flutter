import 'package:flutter/material.dart';
import 'package:zjsdk/zj_sdk.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/my_button.dart';
import 'package:zjsdk_example/view/log_panel.dart';

/// 插屏广告演示页面
class InterstitialPage extends StatelessWidget {
  final LogPanel _logPanel = LogPanel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("插屏广告"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: MyButton("加载插屏广告", action: () {
                _logPanel.setText("开始加载插屏广告");
                ZjSdk.loadInterstitialAd(
                  Constants.interstitialPosId,
                  onZjAdLoaded: () {
                    // 广告加载成功
                    _logPanel.setText("ZjInterstitialAd.onZjAdLoad");
                  },
                  onZjAdShow: () {
                    // 广告展示
                    _logPanel.setText("ZjInterstitialAd.onZjAdShow");
                  },
                  onZjAdClicked: () {
                    // 广告点击
                    _logPanel.setText("ZjInterstitialAd.onZjAdClick");
                  },
                  onZjAdClosed: () {
                    // 广告关闭
                    _logPanel.setText("ZjInterstitialAd.onZjAdClose");
                  },
                  onZjAdError: (int code, String message) {
                    // 广告加载或渲染错误，需要收集错误码和错误信息用于排查定位排查
                    _logPanel.setText(
                        "ZjInterstitialAd.onZjAdError[$code-$message]");
                  },
                );
              }),
            ),
            Align(alignment: Alignment.topCenter, child: _logPanel),
          ],
        ),
      ),
    );
  }
}
