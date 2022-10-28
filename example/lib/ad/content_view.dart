import 'package:flutter/material.dart';
import 'package:zjsdk/zj_content_video_view.dart';
import 'package:zjsdk_example/constants.dart';

/// 视频内容组件演示页面
class ContentViewPage extends StatelessWidget {
  late ZjContentVideoView contentView;

  bool isShowing = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - 80;

    contentView = ZjContentVideoView(
      posId: Constants.contentVideoPosId,
      width: width,
      height: height,
      onPageEnter: (String id) {
        // 页面进入
        print("ZjContentAd.onPageEnter[$id]");
      },
      onPageResume: (String id) {
        // 页面恢复
        print("ZjContentAd.onPageResume[$id]");
      },
      onPagePause: (String id) {
        // 页面暂停
        print("ZjContentAd.onPagePause[$id]");
      },
      onPageLeave: (String id) {
        // 页面离开
        print("ZjContentAd.onPageLeave[$id]");
      },
      onVideoPlayStart: (String id) {
        // 视频播放开始
        print("ZjContentAd.onVideoPlayStart[$id]");
      },
      onVideoPlayPaused: (String id) {
        // 视频播放暂停
        print("ZjContentAd.onVideoPlayPaused[$id]");
      },
      onVideoPlayResume: (String id) {
        // 视频播放恢复
        print("ZjContentAd.onVideoPlayResume[$id]");
      },
      onVideoPlayCompleted: (String id) {
        // 视频播放完成
        print("ZjContentAd.onVideoPlayCompleted[$id]");
      },
      onVideoPlayError: (String id) {
        // 视频播放错误
        print("ZjContentAd.onVideoPlayError[$id]");
      },
      onZjAdError: (int code, String? message) {
        // 广告加载错误
        print("ZjContentAd.onZjAdError[$code-$message]");
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("视频内容组件"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: contentView,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: Text("显示/隐藏"),
                  onPressed: () {
                    if (isShowing) {
                      contentView.hideAd();
                      isShowing = false;
                    } else {
                      isShowing = true;
                      contentView.showAd();
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
