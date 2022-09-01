import 'package:flutter/material.dart';
import 'package:zjsdk/zj_express_video_ad_view.dart';
import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/view/log_panel.dart';

/// 视频流单条组件演示页面
class ExpressVideoPage extends StatelessWidget {
  final LogPanel _logPanel = LogPanel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - 80;
    return Scaffold(
      appBar: AppBar(
        title: Text("视频流广告"),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: ZjExpressVideoAdView(
                  posId: Constants.expressVideoPosId,
                  width: width,
                  height: height,
                  onZjFeedFullVideoLoad: (String size) {
                    // 广告加载成功
                    _logPanel.setText(
                        "ZjExpressVideoAd.onZjFeedFullVideoLoad, ret.size = $size");
                  },
                  onZjAdError: (int code, String message) {
                    // 广告加载失败
                    _logPanel.setText(
                        "ZjExpressVideoAd.onZjAdError[$code-$message]");
                  },
                  onRenderSuccess: () {
                    // 广告渲染成功
                    _logPanel.setText("ZjExpressVideoAd.onZjAdShow");
                  },
                  onRenderFail: (int code, String message) {
                    // 广告渲染失败
                    _logPanel.setText(
                        "ZjExpressVideoAd.onRenderFail[$code-$message]");
                  },
                  onZjAdShow: () {
                    // 广告展示
                    _logPanel.setText("ZjExpressVideoAd.onZjAdClick");
                  },
                  onZjAdClicked: () {
                    // 广告点击
                    _logPanel.setText("ZjExpressVideoAd.onZjAdClick");
                  }),
            ),
            Align(alignment: Alignment.bottomCenter, child: _logPanel),
          ],
        ),
      ),
    );
  }
}
