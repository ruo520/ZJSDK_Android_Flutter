# Android-ZjSdk flutter plugin example

Demonstrates how to use the ZjSdk plugin.

---

## 导入 SDK

1. 参照 example 将`android/app/libs`目录下的 jar 与 aar 包复制到工程 module 对应的 libs 目录下

2. 参照 example 的`android/app/build.gradle`，引入 SDK 所需资源

3. 配置`pubspec`
```yaml
zjsdk:
    path: ../
```

4. 使用`测试ID`接入时，需要**将工程的 applicationId 修改为测试包名**

## 初始化 SDK

### 测试 ID 信息

见[example-Constants](./lib/constants.dart)

### 注册插件

在工程`MainActivity`的 `configureFlutterEngine` 周期中，调用`flutterEngine.getPlugins(FlutterPlugin plugin).add()`方法注册`ZjSdkPlugin`插件，如

```java
import androidx.annotation.NonNull;

import com.zj.zjsdk.plugin.ZjSdkPlugin;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterFragmentActivity {

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    // 注册广告插件
    flutterEngine.getPlugins().add(new ZjSdkPlugin());
  }

}
```

### 在原生的 Application 中调用初始化方法

1.建议在`Application`的`onCreate()`周期中调用初始化方法，可以参照 example 先创建`Application`类继承`FlutterApplication`，然后配置`AndroidManifest.xml`的`<application`节点，指定`android:name:`为自定义的`Application`类

2.调用`ZjSdk.init(Context applicationContext, String appId);`方法初始化 SDK

## 请求广告

### 开屏广告

#### 原生环境请求开屏广告

开屏广告可以通过原生的方式请求，见[example-SplashActivity](./android/app/src/main/java/com/zj/zjsdk/example/SplashActivity.java)，通过配置应用的 launcher 先跳转原生开屏广告的 Activity 后再进入 Flutter 的 MainActivity，也可以根据需求在合适实际通过原生方法调用开屏广告

#### ZjSplashAdView

在应用内通过`ZjSplashAdView`加载开屏广告，需要指定宽高，见[example-splash](./lib/ad/splash.dart)

### 激励视频广告

1.在应用内通过调用`ZjSdk.loadRewardVideoAd`方法，传入广告位 ID 与回调方法，加载并自动播放激励视频广告，见[example-reward-video](./lib/ad/reward_video.dart)

2.应用需要根据`onZjAdError`回调处理加载失败或播放错误

3.应用需要根据`onZjAdReward`回调处理发奖逻辑

4.应用可以在`onZjAdClose`回调监听用户关闭广告页面

### 插屏广告

1.在应用内通过调用`ZjSdk.loadInterstitialAd`方法，传入广告位 ID 与回调方法，加载并自动展示插屏广告，见[example-interstitial](./lib/ad/interstitial.dart)

2.应用需要根据`onZjAdError`回调处理加载失败或渲染错误

3.应用可以在`onZjAdClosed`回调监听用户关闭广告页面

### 全屏视频广告

1.在应用内通过调用`ZjSdk.loadFullScreenVideoAd`方法，传入广告位 ID 与回调方法，加载并自动展示全屏视频广告，见[example-full-screen-video](./lib/ad/full_screen_video.dart)

2.应用需要根据`onZjAdError`回调处理加载失败或渲染错误

3.应用可以在`onZjAdClosed`回调监听用户关闭广告页面

### H5广告

1.调用`ZjSdk.loadH5Ad`方法[example-h5-ad](./lib/ad/h5_ad.dart)，传入广告位ID、用户ID、用户昵称、头像URL，调用展示H5广告页面

2.应用可以在`onGameExit`回调监听用户关闭广告页面

### 视频内容

#### 原生环境请求视频内容

调用`ZjSdk.loadContentVideo(String posId)`方法[example-content-activity](./lib/ad/content_activity.dart)，通过原生的[ZjContentActivity](../android/src/main/java/com/zj/zjsdk/plugin/ZjContentActivity.java)展示视频内容广告

开发者可以通过调整[ZjContentActivity](../android/src/main/java/com/zj/zjsdk/plugin/ZjContentActivity.java)增加统计观看时长、观看数量、发奖等回调逻辑

#### ZjContentVideoView

在应用内通过`ZjContentVideoView`加载视频内容广告，需要指定宽高，见[example-content-view](./lib/ad/content_view.dart)

### Banner 横幅广告

在应用内通过`ZjBannerAdView`加载横幅广告，需要指定宽高，见[example-banner-view](./lib/ad/banner_view.dart)

### 信息流广告

在应用内通过`ZjNativeExpressAdView`加载信息流广告，需要指定宽高，见[example-native-express-view](./lib/ad/native_express_view.dart)

### 视频流广告

在应用内通过`ZjExpressVideoAdView`加载视频流广告，需要指定宽高，见[example-express-video-view](./lib/ad/express_video_view.dart)
