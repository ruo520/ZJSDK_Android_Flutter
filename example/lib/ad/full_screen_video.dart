import 'package:flutter/material.dart';
import 'package:zjsdk/zj_sdk.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/my_button.dart';
import 'package:zjsdk_example/view/log_panel.dart';

/// 全屏视频广告演示页面
class FullScreenVideoPage extends StatelessWidget {
  final LogPanel _logPanel = LogPanel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("全屏视频"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: MyButton("加载全屏视频广告", action: () {
                _logPanel.setText("开始加载全屏视频广告");
                ZjSdk.loadFullScreenVideoAd(
                  Constants.fullScreenVideoPosId,
                  onZjAdLoaded: () {
                    // 广告加载成功
                    _logPanel.setText("ZjFullScreenVideoAd.onZjAdLoad");
                  },
                  onZjAdShow: () {
                    // 广告展示
                    _logPanel.setText("ZjFullScreenVideoAd.onZjAdShow");
                  },
                  onZjAdClick: () {
                    // 广告点击
                    _logPanel.setText("ZjFullScreenVideoAd.onZjAdClick");
                  },
                  onZjAdVideoComplete: () {
                    // 广告播放完成
                    _logPanel.setText("ZjFullScreenVideoAd.onVideoComplete");
                  },
                  onZjAdClose: () {
                    // 广告关闭
                    _logPanel.setText("ZjFullScreenVideoAd.onZjAdClose");
                  },
                  onZjAdError: (int code, String? message) {
                    // 广告加载或播放错误，需要收集错误码和错误信息用于排查定位排查
                    _logPanel.setText(
                        "ZjFullScreenVideoAd.onZjAdError[$code-$message]");
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
