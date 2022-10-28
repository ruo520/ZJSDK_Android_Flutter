import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:zjsdk/zj_sdk.dart';

import 'package:zjsdk_example/constants.dart';
import 'package:zjsdk_example/ad/splash.dart';
import 'package:zjsdk_example/ad/reward_video.dart';
import 'package:zjsdk_example/ad/interstitial.dart';
import 'package:zjsdk_example/ad/full_screen_video.dart';
import 'package:zjsdk_example/ad/h5_ad.dart';
import 'package:zjsdk_example/ad/content_activity.dart';
import 'package:zjsdk_example/ad/content_view.dart';
import 'package:zjsdk_example/ad/banner_view.dart';
import 'package:zjsdk_example/ad/native_express_view.dart';
import 'package:zjsdk_example/ad/express_video_view.dart';
import 'package:zjsdk_example/view/my_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(minWidth: 200),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white),
          )),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => SplashPage(),
        '/reward-video': (BuildContext context) => RewardVideoPage(),
        '/interstitial': (BuildContext context) => InterstitialPage(),
        '/full-screen-video': (BuildContext context) => FullScreenVideoPage(),
        '/h5-ad': (BuildContext context) => H5AdPage(),
        '/content-video-activity': (BuildContext context) =>
            ContentActivityPage(),
        '/content-video-view': (BuildContext context) => ContentViewPage(),
        '/banner-view': (BuildContext context) => BannerViewPage(),
        '/native-express-view': (BuildContext context) => NativeExpressPage(),
        '/express-video-view': (BuildContext context) => ExpressVideoPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      appBar: AppBar(title: Text("ZjSdk_Flutter_Plugin_Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyButton("初始化SDK", action: () {
              // 初始化SDK
              ZjSdk.initSdk(Constants.appId, onSuccess: () {
                Fluttertoast.showToast(msg: "ZjSdk.initSuccess");
              }, onFailure: () {
                Fluttertoast.showToast(msg: "ZjSdk.initFailure");
              });
            }),
            MyButton("开屏广告", context: context, navigate: ('/splash')),
            MyButton("激励视频广告", context: context, navigate: ('/reward-video')),
            MyButton("插屏广告", context: context, navigate: ('/interstitial')),
            MyButton("全屏视频广告",
                context: context, navigate: ('/full-screen-video')),
            MyButton("H5广告", context: context, navigate: ('/h5-ad')),
            MyButton("原生视频内容",
                context: context, navigate: ('/content-video-activity')),
            MyButton("视频内容组件",
                context: context, navigate: ('/content-video-view')),
            MyButton("Banner广告组件",
                context: context, navigate: ('/banner-view')),
            MyButton("信息流广告",
                context: context, navigate: ('/native-express-view')),
            MyButton("视频流广告",
                context: context, navigate: ('/express-video-view')),
          ],
        ),
      ),
    );
  }
}
