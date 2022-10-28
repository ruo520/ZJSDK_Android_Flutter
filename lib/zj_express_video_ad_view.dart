import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'zj_callback.dart';

/// Widget for ZjExpressFeedFullVideo
class ZjExpressVideoAdView extends StatelessWidget {
  /// 广告位ID
  final String posId;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 加载成功
  final AdCallback1? onZjFeedFullVideoLoad;

  /// 加载失败
  final AdErrorCallback? onZjAdError;

  /// 渲染成功
  final AdCallback0? onRenderSuccess;

  /// 渲染失败
  final AdErrorCallback? onRenderFail;

  /// 广告展示成功
  final AdCallback0? onZjAdShow;

  /// 广告点击
  final AdCallback0? onZjAdClicked;

  ZjExpressVideoAdView(
      {Key? key,
      required this.posId,
      required this.width,
      required this.height,
      this.onZjFeedFullVideoLoad,
      this.onZjAdError,
      this.onRenderSuccess,
      this.onRenderFail,
      this.onZjAdShow,
      this.onZjAdClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget expressVideo;
    if (defaultTargetPlatform == TargetPlatform.android) {
      expressVideo = AndroidView(
        viewType: 'flutter_zjsdk_plugin/express_video',
        creationParams: {
          "posId": posId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      expressVideo = Text("Not supported");
    }

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: expressVideo,
          ),
        ],
      ),
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/express_video_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onZjFeedFullVideoLoad":
          print("ZjExpressFeedFullVideoAd.onZjFeedFullVideoLoad");
          onZjFeedFullVideoLoad?.call(event["size"]);
          break;

        case "onZjAdError":
          print(
              "ZjExpressFeedFullVideoAd.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;

        case "onRenderSuccess":
          print("ZjExpressFeedFullVideoAd.onRenderSuccess");
          onRenderSuccess?.call();
          break;

        case "onRenderFail":
          print(
              "ZjExpressFeedFullVideoAd.onRenderFail[${event["code"]}-${event["message"]}");
          onRenderFail?.call(event["code"], event["message"]);
          break;

        case "onZjAdShow":
          print("ZjExpressFeedFullVideoAd.onZjAdShow");
          onZjAdShow?.call();
          break;

        case "onZjAdClicked":
          print("ZjExpressFeedFullVideoAd.onZjAdClicked");
          onZjAdClicked?.call();
          break;
      }
    });
  }
}
