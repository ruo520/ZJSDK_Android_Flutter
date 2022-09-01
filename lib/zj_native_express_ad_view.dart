import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'zj_callback.dart';

/// Widget for ZjNativeExpressAd
class ZjNativeExpressAdView extends StatelessWidget {
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

  ZjNativeExpressAdView(
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
    Widget nativeExpress;
    if (defaultTargetPlatform == TargetPlatform.android) {
      nativeExpress = AndroidView(
        viewType: 'flutter_zjsdk_plugin/native_express',
        creationParams: {
          "posId": posId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      nativeExpress = Text("Not supported");
    }

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: nativeExpress,
          ),
        ],
      ),
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/native_express_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onZjAdLoaded":
          print("ZjNativeExpressAd.onZjAdLoaded");
          onZjAdLoaded?.call();
          break;

        case "onZjAdShow":
          print("ZjNativeExpressAd.onZjAdShow");
          onZjAdShow?.call();
          break;

        case "onZjAdClicked":
          print("ZjNativeExpressAd.onZjAdClicked");
          onZjAdClicked?.call();
          break;

        case "onZjAdClosed":
          print("ZjNativeExpressAd.onZjAdClosed");
          onZjAdClosed?.call();
          break;

        case "onZjAdError":
          print(
              "ZjNativeExpressAd.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;
      }
    });
  }
}
