import 'package:flutter/material.dart';
import 'package:zjsdk/zj_sdk.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/my_button.dart';
import 'package:zjsdk_example/view/log_panel.dart';

/// 激励视频演示页面
class RewardVideoPage extends StatelessWidget {
  final LogPanel _logPanel = LogPanel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("激励视频"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: MyButton("加载激励视频广告", action: () {
                _logPanel.setText("开始请求激励视频广告");
                ZjSdk.loadRewardVideoAd(
                  Constants.rewardVideoPosId,
                  onZjAdTradeId: (String tradeId) {
                    // 返回交易ID
                    _logPanel
                        .setText("ZjRewardVideoAd.onZjAdTradeId[$tradeId]");
                  },
                  onZjAdLoaded: () {
                    // 广告加载成功
                    _logPanel.setText("ZjRewardVideoAd.onZjAdLoad");
                  },
                  onZjAdVideoCached: () {
                    // 广告素材缓存成功
                    _logPanel.setText("ZjRewardVideoAd.onZjAdVideoCached");
                  },
                  onZjAdShow: () {
                    // 广告展示
                    _logPanel.setText("ZjRewardVideoAd.onZjAdShow");
                  },
                  onZjAdReward: () {
                    // 广告满足奖励条件
                    _logPanel.setText("ZjRewardVideoAd.onReward");
                  },
                  onZjAdClick: () {
                    // 广告点击
                    _logPanel.setText("ZjRewardVideoAd.onZjAdClick");
                  },
                  onZjAdVideoComplete: () {
                    // 广告视频播放结束
                    _logPanel.setText("ZjRewardVideoAd.onVideoComplete");
                  },
                  onZjAdClose: () {
                    // 广告关闭
                    _logPanel.setText("ZjRewardVideoAd.onZjAdClose");
                  },
                  onZjAdError: (int code, String? message) {
                    // 广告加载或播放错误，需要收集错误码和错误信息用于排查定位排查
                    _logPanel
                        .setText("ZjRewardVideoAd.onZjAdError[$code-$message]");
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
