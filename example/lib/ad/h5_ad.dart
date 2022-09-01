import 'package:flutter/material.dart';
import 'package:zjsdk/zj_sdk.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/my_button.dart';
import 'package:zjsdk_example/view/log_panel.dart';

/// H5广告演示页面
class H5AdPage extends StatelessWidget {
  final LogPanel _logPanel = LogPanel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H5广告"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: MyButton("加载H5广告", action: () {
                _logPanel.setText("开始加载H5广告");
                ZjSdk.loadH5Ad(
                  Constants.h5AdPosId,
                  "uid-18888888888",
                  username: "username-Jerry",
                  avatarUrl: "avatarUrl-https://xxx.xxx/xxx.xxx",
                  onIntegralNotEnough: (String? uid, int? needIntegral) {
                    // 积分不够
                    _logPanel.setText(
                        "ZjH5Ad.onIntegralNotEnough, needIntegral = $needIntegral");
                  },
                  onIntegralExpend: (String uid, int expendIntegral) {
                    /*
                       * 积分消耗
                       * expendIntegral>0，用户消耗了多少积分
                       * expendIntegral<0，用户任务完成领取了多少积分
                       **/
                    _logPanel.setText(
                        "ZjH5Ad.onIntegralExpend, expendIntegral = $expendIntegral");
                  },
                  onFinishTasks: (String uid, int finishTasks) {
                    // 返回的是完成的任务总数
                    _logPanel.setText(
                        "ZjH5Ad.onFinishTasks, finishTasks = $finishTasks");
                  },
                  onGameExit: (String uid) {
                    // 退出H5
                    _logPanel.setText("ZjH5Ad.onGameExit");
                  },
                  onZjAdRewardFinish: (String uid, int rewardIntegral) {
                    /*
                       * 看广告奖励触发
                       * rewardIntegral -> 完成总任务数
                       **/
                    _logPanel.setText(
                        "ZjH5Ad.onZjAdRewardFinish, rewardIntegral = $rewardIntegral");
                  },
                  onZjAdClick: () {
                    // H5页面中观看激励视频时的点击广告的返回事件
                    _logPanel.setText("ZjH5Ad.onZjAdClick");
                  },
                  onZjAdReward: () {
                    // 看广告奖励触发
                    _logPanel.setText("ZjH5Ad.onZjAdReward");
                  },
                  onZjAdLoaded: () {
                    // H5页面的激励视频加载成功
                    _logPanel.setText("ZjH5Ad.onZjAdLoaded");
                  },
                  onZjAdTradeId: (String tradeId) {
                    // H5页面的激励视频返回交易ID
                    _logPanel.setText("ZjH5Ad.onZjAdTradeId");
                  },
                  onZjUserBehavior: (String behavior) {
                    /*
                       * H5页面中的用户行为
                       * joinLottery --> 参与抽奖
                       * joinSurvey --> 参与测一测
                       * joinGuessingIdioms --> 参与猜成语
                       * stay60s --> 新闻资讯浏览超过60s的回调
                       * joinGame --> 参与游戏
                       * taskSignIn --> 签到成功
                       **/
                    _logPanel.setText(
                        "ZjH5Ad.onZjUserBehavior, behavior = $behavior");
                  },
                  onZjAdError: (int code, String? message) {
                    // H5页面加载错误
                    _logPanel.setText("ZjH5Ad.onZjAdError[$code-$message]");
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
