import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'zj_callback.dart';

/// Widget for ZjBannerAd
class ZjBannerAdView extends StatelessWidget {
  /// 广告位ID
  final String posId;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 加载成功
  final AdCallback0 onZjAdLoaded;

  /// 曝光成功
  final AdCallback0 onZjAdShow;

  /// 广告点击
  final AdCallback0 onZjAdClicked;

  /// 广告关闭
  final AdCallback0 onZjAdClosed;

  /// 广告错误
  final AdErrorCallback onZjAdError;

  ZjBannerAdView(
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
    Widget banner;
    if (defaultTargetPlatform == TargetPlatform.android) {
      banner = AndroidView(
        viewType: 'flutter_zjsdk_plugin/banner',
        creationParams: {
          "posId": posId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      banner = Text("Not supported");
    }

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: banner,
          ),
        ],
      ),
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/banner_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onZjAdLoaded":
          print("ZjBannerAd.onZjAdLoaded");
          onZjAdLoaded?.call();
          break;

        case "onZjAdShow":
          print("ZjBannerAd.onZjAdShow");
          onZjAdShow?.call();
          break;

        case "onZjAdClicked":
          print("ZjBannerAd.onZjAdClicked");
          onZjAdClicked?.call();
          break;

        case "onZjAdClosed":
          print("ZjBannerAd.onZjAdClosed");
          onZjAdClosed?.call();
          break;

        case "onZjAdError":
          print("ZjBannerAd.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;
      }
    });
  }
}
