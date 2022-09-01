import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'zj_callback.dart';

/// Widget for ZjContentAd
class ZjContentVideoView extends StatelessWidget {
  /// 广告位ID
  final String posId;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 页面进入
  final AdCallback1 onPageEnter;

  /// 页面恢复
  final AdCallback1 onPageResume;

  /// 页面暂停
  final AdCallback1 onPagePause;

  /// 页面离开
  final AdCallback1 onPageLeave;

  /// 视频开始
  final AdCallback1 onVideoPlayStart;

  /// 视频暂停
  final AdCallback1 onVideoPlayPaused;

  /// 视频恢复
  final AdCallback1 onVideoPlayResume;

  /// 视频播放完成
  final AdCallback1 onVideoPlayCompleted;

  /// 视频播放错误
  final AdCallback1 onVideoPlayError;

  /// 加载错误
  final AdErrorCallback onZjAdError;

  MethodChannel _methodChannel;

  ZjContentVideoView(
      {Key key,
      @required this.posId,
      @required this.width,
      @required this.height,
      this.onPageEnter,
      this.onPageResume,
      this.onPagePause,
      this.onPageLeave,
      this.onVideoPlayStart,
      this.onVideoPlayPaused,
      this.onVideoPlayResume,
      this.onVideoPlayCompleted,
      this.onVideoPlayError,
      this.onZjAdError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (defaultTargetPlatform == TargetPlatform.android) {
      content = AndroidView(
        viewType: 'flutter_zjsdk_plugin/content_video',
        creationParams: {
          "posId": posId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      content = Text("Not supported");
    }

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: content,
          ),
        ],
      ),
    );
  }

  void _onPlatformViewCreated(int id) {
    _methodChannel =
        new MethodChannel("flutter_zjsdk_plugin/content_video_method_$id");
    EventChannel eventChannel =
        EventChannel("flutter_zjsdk_plugin/content_video_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "onPageEnter":
          print("ZjContentAd.onPageEnter");
          onPageEnter?.call(event["id"]);
          break;

        case "onPageResume":
          print("ZjContentAd.onPageResume");
          onPageResume?.call(event["id"]);
          break;

        case "onPagePause":
          print("ZjContentAd.onPagePause");
          onPagePause?.call(event["id"]);
          break;

        case "onPageLeave":
          print("ZjContentAd.onPageLeave");
          onPageLeave?.call(event["id"]);
          break;

        case "onVideoPlayStart":
          print("ZjContentAd.onVideoPlayStart");
          onVideoPlayStart?.call(event["id"]);
          break;

        case "onVideoPlayPaused":
          print("ZjContentAd.onVideoPlayPaused");
          onVideoPlayPaused?.call(event["id"]);
          break;

        case "onVideoPlayResume":
          print("ZjContentAd.onVideoPlayResume");
          onVideoPlayResume?.call(event["id"]);
          break;

        case "onVideoPlayCompleted":
          print("ZjContentAd.onVideoPlayCompleted");
          onVideoPlayCompleted?.call(event["id"]);
          break;

        case "onVideoPlayError":
          print("ZjContentAd.onVideoPlayError");
          onVideoPlayError?.call(event["id"]);
          break;

        case "onZjAdError":
          print("ZjContentAd.onZjAdError[${event["code"]}-${event["message"]}");
          onZjAdError?.call(event["code"], event["message"]);
          break;
      }
    });
  }

  void showAd() {
    _methodChannel.invokeMethod("showAd");
  }

  void hideAd() {
    _methodChannel.invokeMethod("hideAd");
  }
}
