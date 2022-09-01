import 'package:flutter/material.dart';
import 'package:zjsdk/zj_native_express_ad_view.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/log_panel.dart';

/// 信息流组件演示页面
class NativeExpressPage extends StatelessWidget {
  final LogPanel _logPanel = LogPanel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("信息流广告"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: ZjNativeExpressAdView(
                posId: Constants.nativeExpressPosId,
                width: 400,
                height: 250,
                onZjAdLoaded: () {
                  // 广告加载成功
                  _logPanel.setText("ZjNativeExpressAd.onZjAdLoad");
                },
                onZjAdShow: () {
                  // 广告展示
                  _logPanel.setText("ZjNativeExpressAd.onZjAdShow");
                },
                onZjAdClicked: () {
                  // 广告点击
                  _logPanel.setText("ZjNativeExpressAd.onZjAdClick");
                },
                onZjAdClosed: () {
                  // 广告关闭
                  _logPanel.setText("ZjNativeExpressAd.onZjAdClose");
                },
                onZjAdError: (int code, String? message) {
                  // 广告错误
                  _logPanel
                      .setText("ZjNativeExpressAd.onZjAdError[$code-$message]");
                },
              ),
            ),
            Positioned(top: 0, child: _logPanel),
          ],
        ),
      ),
    );
  }
}
