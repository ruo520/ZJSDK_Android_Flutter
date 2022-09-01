import 'package:flutter/services.dart';
import 'zj_callback.dart';

/// API for showing various types of advertisements
class ZjSdk {
  static MethodChannel _methodChannel =
      new MethodChannel("flutter_zjsdk_plugin/method");

  /// init ZjSdk
  static void initSdk(

      /// 应用ID
      String appId,
      {

      /// 初始化成功
      AdCallback0 onSuccess,

      /// 初始化失败
      AdCallback0 onFailure}) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/event_init_sdk");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onSuccess":
          print("ZjSdk.initSuccess");
          onSuccess?.call();
          break;
        case "onFailure":
          print("ZjSdk.onFailure");
          onFailure?.call();
          break;
      }
    });
    _methodChannel.invokeMethod("initSdk", {"appId": appId});
  }

  /// load ZjRewardVideo
  static void loadRewardVideoAd(

      /// 广告位ID
      String posId,
      {

      ///返回交易ID
      AdCallback1 onZjAdTradeId,

      /// 加载成功
      AdCallback0 onZjAdLoaded,

      /// 素材缓存成功
      AdCallback0 onZjAdVideoCached,

      /// 广告展示
      AdCallback0 onZjAdShow,

      /// 广告获得奖励
      AdCallback0 onZjAdReward,

      /// 广告点击
      AdCallback0 onZjAdClick,

      /// 广告播放完成
      AdCallback0 onZjAdVideoComplete,

      /// 广告被关闭
      AdCallback0 onZjAdClose,

      /// 广告错误
      AdErrorCallback onZjAdError}) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/event_reward_video");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onZjAdTradeId":
          print("ZjRewardVideoAd.onZjAdTradeId");
          onZjAdTradeId?.call(event["tradeId"]);
          break;

        case "onZjAdLoaded":
          print("ZjRewardVideoAd.onZjAdLoaded");
          onZjAdLoaded?.call();
          break;

        case "onZjAdVideoCached":
          print("ZjRewardVideoAd.onZjAdVideoCached");
          onZjAdVideoCached?.call();
          break;

        case "onZjAdShow":
          print("ZjRewardVideoAd.onZjAdShow");
          onZjAdShow?.call();
          break;

        case "onZjAdReward":
          print("ZjRewardVideoAd.onZjAdReward");
          onZjAdReward?.call();
          break;

        case "onZjAdClick":
          print("ZjRewardVideoAd.onZjAdClick");
          onZjAdClick?.call();
          break;

        case "onZjAdVideoComplete":
          print("ZjRewardVideoAd.onZjAdVideoComplete");
          onZjAdVideoComplete?.call();
          break;

        case "onZjAdClose":
          print("ZjRewardVideoAd.onZjAdClose");
          onZjAdClose?.call();
          break;

        case "onZjAdError":
          print(
              "ZjRewardVideoAd.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;
      }
    });
    _methodChannel.invokeMethod("loadRewardVideoAd", {"posId": posId});
  }

  /// load ZjInterstitialAd
  static void loadInterstitialAd(

      /// 广告位ID
      String posId,
      {

      /// 加载成功
      AdCallback0 onZjAdLoaded,

      /// 广告展示
      AdCallback0 onZjAdShow,

      /// 广告点击
      AdCallback0 onZjAdClicked,

      /// 广告关闭
      AdCallback0 onZjAdClosed,

      /// 广告错误
      AdErrorCallback onZjAdError}) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/event_interstitial");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onZjAdLoaded":
          print("ZjInterstitialAd.onZjAdLoaded");
          onZjAdLoaded?.call();
          break;

        case "onZjAdShow":
          print("ZjInterstitialAd.onZjAdError");
          onZjAdShow?.call();
          break;

        case "onZjAdClicked":
          print("ZjInterstitialAd.onZjAdClicked");
          onZjAdClicked?.call();
          break;

        case "onZjAdClosed":
          print("ZjInterstitialAd.onZjAdClosed");
          onZjAdClosed?.call();
          break;

        case "onZjAdError":
          print(
              "ZjInterstitialAd.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;
      }
    });
    _methodChannel.invokeMethod("loadInterstitialAd", {"posId": posId});
  }

  /// load ZjFullScreenVideoAd
  static void loadFullScreenVideoAd(

      /// 广告位ID
      String posId,
      {

      /// 加载成功
      AdCallback0 onZjAdLoaded,

      /// 素材缓存成功
      AdCallback0 onZjAdVideoCached,

      /// 广告展示
      AdCallback0 onZjAdShow,

      /// 广告点击
      AdCallback0 onZjAdClick,

      /// 广告播放完成
      AdCallback0 onZjAdVideoComplete,

      /// 广告关闭
      AdCallback0 onZjAdClose,

      /// 广告错误
      AdErrorCallback onZjAdError}) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/event_full_screen_video");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onZjAdLoaded":
          print("ZjFullScreenVideoAd.onZjAdLoaded");
          onZjAdLoaded?.call();
          break;

        case "onZjAdVideoCached":
          print("ZjFullScreenVideoAd.onZjAdVideoCached");
          onZjAdVideoCached?.call();
          break;

        case "onZjAdShow":
          print("ZjFullScreenVideoAd.onZjAdShow");
          onZjAdShow?.call();
          break;

        case "onZjAdClick":
          print("ZjFullScreenVideoAd.onZjAdClick");
          onZjAdClick?.call();
          break;

        case "onZjAdVideoComplete":
          print("ZjFullScreenVideoAd.onZjAdVideoComplete");
          onZjAdVideoComplete?.call();
          break;

        case "onZjAdClose":
          print("ZjFullScreenVideoAd.onZjAdClose");
          onZjAdClose?.call();
          break;

        case "onZjAdError":
          print(
              "ZjFullScreenVideoAd.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;
      }
    });
    _methodChannel.invokeMethod("loadFullScreenVideoAd", {"posId": posId});
  }

  /// load ZjH5Ad
  static void loadH5Ad(

      /// 广告位ID
      String posId,

      /// 用户ID
      String userId,
      {

      /// 用户名
      String username,

      /// 头像Url
      String avatarUrl,

      /// 积分不足，返回需要的积分
      AdCallback2 onIntegralNotEnough,

      /// 积分消耗，>0消耗积分，<0获得积分
      AdCallback2 onIntegralExpend,

      /// 完成任务，返回已完成的任务总数
      AdCallback2 onFinishTasks,

      /// 退出H5
      AdCallback1 onGameExit,

      /// H5页面中激励视频触发激励，返回的是完成总任务数
      AdCallback2 onZjAdRewardFinish,

      /// 看广告奖励触发
      AdCallback0 onZjAdReward,

      /// H5页面中激励视频加载成功
      AdCallback0 onZjAdLoaded,

      /// H5页面中激励视频返回交易ID
      AdCallback1 onZjAdTradeId,

      /// H5页面中激励视频点击
      AdCallback0 onZjAdClick,

      /// 用户页面的行为操作，具体行为见文档
      AdCallback1 onZjUserBehavior,

      /// 加载错误
      AdErrorCallback onZjAdError}) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/event_h5_ad");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onIntegralNotEnough":
          print("ZjH5Ad.onIntegralNotEnough");
          onIntegralNotEnough?.call(event["userId"], event["needIntegral"]);
          break;

        case "onIntegralExpend":
          print("ZjH5Ad.onIntegralExpend");
          onIntegralExpend?.call(event["userId"], event["expendIntegral"]);
          break;

        case "onFinishTasks":
          print("ZjH5Ad.onFinishTasks");
          onFinishTasks?.call(event["userId"], event["finishTasks"]);
          break;

        case "onGameExit":
          print("ZjH5Ad.onGameExit");
          onGameExit?.call(event["userId"]);
          break;

        case "onZjAdRewardFinish":
          print("ZjH5Ad.onZjAdRewardFinish");
          onZjAdRewardFinish?.call(event["userId"], event["rewardIntegral"]);
          break;

        case "onZjAdClick":
          print("ZjH5Ad.onZjAdClick");
          onZjAdClick?.call();
          break;

        case "onZjAdReward":
          print("ZjH5Ad.onZjAdReward");
          onZjAdReward?.call();
          break;

        case "onZjAdLoaded":
          print("ZjH5Ad.onZjAdLoaded");
          onZjAdLoaded?.call();
          break;

        case "onZjAdTradeId":
          print("ZjH5Ad.onZjAdTradeId");
          onZjAdTradeId?.call(event["tradeId"]);
          break;

        case "onZjUserBehavior":
          print("ZjH5Ad.onZjUserBehavior");
          onZjUserBehavior?.call(event["behavior"]);
          break;

        case "onZjAdError":
          print("ZjH5Ad.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;
      }
    });

    _methodChannel.invokeMethod("loadH5Ad", {
      "posId": posId,
      "userId": userId,
      "username": username,
      "avatarUrl": avatarUrl
    });
  }

  /// load ZjContentAd with new Activity
  static void loadContentVideo(String posId) {
    _methodChannel.invokeMethod(
        "loadContentVideo", {"_channelId": "contentVideo", "posId": posId});
  }
}
