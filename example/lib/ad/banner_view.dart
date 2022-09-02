import 'package:flutter/material.dart';
import 'package:zjsdk_ext/zj_banner_ad_view.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/log_panel.dart';

/// Banner 广告组件演示页面
class BannerViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LogPanel _logPanel = LogPanel();
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: ZjBannerAdView(
                posId: Constants.bannerPosId,
                width: 400,
                // 宽
                height: 120,
                // 高
                onZjAdLoaded: () {
                  // 广告加载成功
                  _logPanel.setText("ZjBannerAd.onZjAdLoad");
                },
                onZjAdShow: () {
                  // 广告展示
                  _logPanel.setText("ZjBannerAd.onZjAdShow");
                },
                onZjAdClicked: () {
                  // 广告点击
                  _logPanel.setText("ZjBannerAd.onZjAdClick");
                },
                onZjAdClosed: () {
                  // 广告关闭
                  _logPanel.setText("ZjBannerAd.onZjAdClose");
                },
                onZjAdError: (int code, String message) {
                  // 广告加载错误
                  _logPanel.setText("ZjBannerAd.onZjAdError[$code-$message]");
                },
              ),
            ),
            Positioned(top: 130, child: _logPanel),
          ],
        ),
      ),
    );
  }
}
