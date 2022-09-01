import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'zj_callback.dart';

/// Widget for splash ad
class ZjSplashAdView extends StatelessWidget {
  /// 广告位ID
  final String posId;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 广告加载成功
  final AdCallback0 onZjAdLoaded;

  /// 广告展示
  final AdCallback0 onZjAdShow;

  /// 广告点击
  final AdCallback0 onZjAdClicked;

  /// 广告关闭
  final AdCallback0 onZjAdClosed;

  /// 广告错误
  final AdErrorCallback onZjAdError;

  ZjSplashAdView(
      {Key key,
      @required this.posId,
      @required this.width,
      @required this.height,
      this.onZjAdLoaded,
      this.onZjAdShow,
      this.onZjAdClicked,
      this.onZjAdClosed,
      this.onZjAdError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget splash;
    if (defaultTargetPlatform == TargetPlatform.android) {
      splash = AndroidView(
        viewType: 'flutter_zjsdk_plugin/splash',
        creationParams: {
          "posId": posId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      splash = Text("Not supported");
    }

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: splash,
          ),
        ],
      ),
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/splash_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onZjAdLoaded":
          print("ZjSplashAd.onZjAdLoaded");
          onZjAdLoaded?.call();
          break;

        case "onZjAdShow":
          print("ZjSplashAd.onZjAdShow");
          onZjAdShow?.call();
          break;

        case "onZjAdClicked":
          print("ZjSplashAd.onZjAdClicked");
          onZjAdClicked?.call();
          break;

        case "onZjAdClosed":
          print("ZjSplashAd.onZjAdClosed");
          onZjAdClosed?.call();
          break;

        case "onZjAdError":
          print("ZjSplashAd.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;
      }
    });
  }
}
