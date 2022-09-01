package com.zj.zjsdk.plugin;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.zj.zjsdk.ZjH5ContentListener;
import com.zj.zjsdk.ZjSdk;
import com.zj.zjsdk.ZjUser;
import com.zj.zjsdk.ad.ZjAdError;
import com.zj.zjsdk.ad.ZjFullScreenVideoAd;
import com.zj.zjsdk.ad.ZjFullScreenVideoAdListener;
import com.zj.zjsdk.ad.ZjH5Ad;
import com.zj.zjsdk.ad.ZjInterstitialAd;
import com.zj.zjsdk.ad.ZjInterstitialAdListener;
import com.zj.zjsdk.ad.ZjRewardVideoAd;
import com.zj.zjsdk.ad.ZjRewardVideoAdListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.platform.PlatformViewRegistry;

public class ZjSdkPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {

    private static final String TAG = "ZjSdkPlugin";

    private Activity activity;
    private FlutterPluginBinding pluginBinding;

    private BinaryMessenger mBinaryMessenger;

    private void initializePlugin(Activity activity, BinaryMessenger messenger, PlatformViewRegistry registry) {
        this.activity = activity;

        mBinaryMessenger = messenger;
        /// The MethodChannel that will the communication between Flutter and native Android
        ///
        /// This local reference serves to register the plugin with the Flutter Engine and unregister it
        /// when the Flutter Engine is detached from the Activity
        MethodChannel channel = new MethodChannel(mBinaryMessenger, "flutter_zjsdk_plugin/method");
        channel.setMethodCallHandler(this);

        registry.registerViewFactory("flutter_zjsdk_plugin/splash", new ZjSplashAdViewFactory(mBinaryMessenger, activity));
        registry.registerViewFactory("flutter_zjsdk_plugin/banner", new ZjBannerAdViewFactory(mBinaryMessenger, activity));
        registry.registerViewFactory("flutter_zjsdk_plugin/native_express", new ZjNativeExpressAdViewFactory(mBinaryMessenger, activity));
        registry.registerViewFactory("flutter_zjsdk_plugin/express_video", new ZjExpressVideoAdViewFactory(mBinaryMessenger, activity));
        registry.registerViewFactory("flutter_zjsdk_plugin/content_video", new ZjContentAdViewFactory(mBinaryMessenger, activity));

        new EventChannel(mBinaryMessenger, "flutter_zjsdk_plugin/event_init_sdk").setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink es) {
                Log.e(TAG, "initSdk.onListen...");
                initEventSink = es;
            }

            @Override
            public void onCancel(Object o) {
                initEventSink = null;
            }
        });
        new EventChannel(mBinaryMessenger, "flutter_zjsdk_plugin/event_reward_video").setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink es) {
                Log.e(TAG, "loadReward.onListen");
                rewardVideoEventSink = es;
            }

            @Override
            public void onCancel(Object o) {
                rewardVideoEventSink = null;
            }
        });
        new EventChannel(mBinaryMessenger, "flutter_zjsdk_plugin/event_interstitial").setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink es) {
                interstitialEventSink = es;
            }

            @Override
            public void onCancel(Object o) {
                interstitialEventSink = null;
            }
        });
        new EventChannel(mBinaryMessenger, "flutter_zjsdk_plugin/event_full_screen_video").setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink es) {
                fullScreenVideoEventSink = es;
            }

            @Override
            public void onCancel(Object o) {
                fullScreenVideoEventSink = null;
            }
        });
        new EventChannel(mBinaryMessenger, "flutter_zjsdk_plugin/event_h5_ad").setStreamHandler(new EventChannel.StreamHandler() {

            @Override
            public void onListen(Object o, EventChannel.EventSink es) {
                h5AdEventSink = es;
            }

            @Override
            public void onCancel(Object o) {
                h5AdEventSink = null;
            }
        });
    }


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        pluginBinding = flutterPluginBinding;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        // 这里可以处理初始化等事件
        Log.e(TAG, "onMethodCall:" + call.method);
        String posId = call.argument("posId");
        switch (call.method) {
            // 初始化
            case "initSdk":
                initSdk((String) call.argument("appId"));
                break;
            // 激励视频
            case "loadRewardVideoAd":
                loadReward(posId);
                break;
            // 插屏
            case "loadInterstitialAd":
                loadInterstitialAd(posId);
                break;
            // 全屏视频
            case "loadFullScreenVideoAd":
                loadFullScreenVideo(posId);
                break;
            // 视频内容
            case "loadContentVideo":
                startContent(posId);
                break;
            // H5
            case "loadH5Ad":
                loadH5Ad(posId, String.valueOf(call.argument("userId")), String.valueOf(call.argument("username")), String.valueOf(call.argument("avatarUrl")));
                break;
            // 其他
            default:
                result.notImplemented();
                break;
        }
    }

    // EventSink
    EventChannel.EventSink initEventSink;

    /**
     * 初始化SDK
     *
     * @param appId 媒体ID
     */
    private void initSdk(final String appId) {
        ZjSdk.init(activity.getApplicationContext(), appId, new ZjSdk.ZjSdkInitListener() {
            @Override
            public void initSuccess() {
                if (initEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onSuccess");
                    initEventSink.success(result);
                }
            }

            @Override
            public void initFail() {
                if (initEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onFailure");
                    initEventSink.success(result);
                }
            }
        });
    }

    // 加载对话框
    private ProgressDialog pd;

    private void showPd() {
        if (null == pd) {
            pd = new ProgressDialog(activity);
        }
        pd.setMessage("加载中...");
        pd.show();
    }

    private void cancel() {
        if (null != pd) {
            pd.cancel();
            pd = null;
        }
    }


    // 激励视频对象
    ZjRewardVideoAd zjRewardVideoAd = null;
    // EventSink
    EventChannel.EventSink rewardVideoEventSink;
    // 广告加载状态
    boolean isRewardVideoRequesting = false;

    /**
     * 加载激励视频
     *
     * @param posId 广告位ID
     */
    private void loadReward(String posId) {
        Log.e(TAG, "loadReward");

        if (isRewardVideoRequesting) {
            return;
        }

        // 加载中对话框
        showPd();

        zjRewardVideoAd = new ZjRewardVideoAd(activity, posId, new ZjRewardVideoAdListener() {

            @Override
            public void onZjAdTradeId(String tradeId, String key, boolean isVerity) {
                Log.d(TAG, "onZjAdTradeId[" + tradeId + "]");

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdTradeId");
                    result.put("tradeId", tradeId);
                    rewardVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdLoaded(String s) {
                Log.e(TAG, "onZjAdLoaded");

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdLoaded");
                    rewardVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdVideoCached() {
                Log.e(TAG, "onZjAdVideoCached");
                isRewardVideoRequesting = false;
                cancel();

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdVideoCached");
                    rewardVideoEventSink.success(result);
                }
                zjRewardVideoAd.showAD();
            }

            @Override
            public void onZjAdShow() {
                Log.e(TAG, "onZjAdShow");

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdShow");
                    rewardVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdShowError(ZjAdError zjAdError) {
                Log.e(TAG, "onZjAdShowError");
                isRewardVideoRequesting = false;
                cancel();

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdError");
                    result.put("code", zjAdError.getErrorCode());
                    result.put("message", zjAdError.getErrorMsg());
                    rewardVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdClick() {
                Log.e(TAG, "onZjAdClick");

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClick");
                    rewardVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdVideoComplete() {
                Log.e(TAG, "onZjAdVideoComplete");

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdVideoComplete");
                    rewardVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdReward(String s) {
                Log.e(TAG, "onZjAdReward");

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdReward");
                    rewardVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdClose() {
                Log.e(TAG, "onZjAdClose");
                isRewardVideoRequesting = false;

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClose");
                    rewardVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdError(ZjAdError zjAdError) {
                Log.d(TAG, "onZjAdError[" + zjAdError.getErrorCode() + "-" + zjAdError.getErrorMsg() + "]");
                isRewardVideoRequesting = false;
                cancel();

                if (rewardVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdError");
                    result.put("code", zjAdError.getErrorCode());
                    result.put("message", zjAdError.getErrorMsg());
                    rewardVideoEventSink.success(result);
                }
            }
        });

        zjRewardVideoAd.loadAd();
    }

    // 插屏对象
    ZjInterstitialAd zjInterstitialAd = null;
    // EventSink
    EventChannel.EventSink interstitialEventSink;
    // 广告加载状态
    boolean isInterstitialAdRequesting = false;

    /**
     * 加载插屏广告
     *
     * @param posId 广告位ID
     */
    private void loadInterstitialAd(String posId) {
        if (isInterstitialAdRequesting) {
            return;
        }

        isInterstitialAdRequesting = true;

        zjInterstitialAd = new ZjInterstitialAd(activity, posId, new ZjInterstitialAdListener() {

            @Override
            public void onZjAdClosed() {
                Log.d(TAG, "onZjAdClosed");

                if (interstitialEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClosed");
                    interstitialEventSink.success(result);
                }
            }

            @Override
            public void onZjAdLoaded() {
                Log.d(TAG, "onZjAdLoaded");

                isInterstitialAdRequesting = false;

                if (interstitialEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdLoaded");
                    interstitialEventSink.success(result);
                }

                zjInterstitialAd.showAd(activity);
            }

            @Override
            public void onZjAdShow() {
                Log.d(TAG, "onZjAdShow");

                if (interstitialEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdShow");
                    interstitialEventSink.success(result);
                }
            }

            @Override
            public void onZjAdClicked() {
                Log.d(TAG, "onZjAdClicked");

                if (interstitialEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClicked");
                    interstitialEventSink.success(result);
                }
            }

            @Override
            public void onZjAdError(ZjAdError adError) {
                Log.d(TAG, "onZjAdError[" + adError.getErrorCode() + "-" + adError.getErrorMsg() + "]");

                isInterstitialAdRequesting = false;

                if (interstitialEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdError");
                    result.put("code", adError.getErrorCode());
                    result.put("message", adError.getErrorMsg());
                    interstitialEventSink.success(result);
                }
            }
        });
        zjInterstitialAd.loadAd();
    }

    // 全屏视频
    ZjFullScreenVideoAd zjFullScreenVideoAd = null;
    // EventSink
    EventChannel.EventSink fullScreenVideoEventSink;
    // 广告加载状态
    boolean isFullScreenVideoRequesting = false;

    /**
     * 加载插屏广告
     *
     * @param posId 广告位ID
     */
    private void loadFullScreenVideo(String posId) {

        if (isFullScreenVideoRequesting) {
            return;
        }

        showPd();

        isFullScreenVideoRequesting = true;

        zjFullScreenVideoAd = new ZjFullScreenVideoAd(activity, posId, new ZjFullScreenVideoAdListener() {

            @Override
            public void onZjAdLoaded() {
                Log.e(TAG, "onZjAdLoaded");

                if (fullScreenVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdLoaded");
                    fullScreenVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdVideoCached() {
                Log.e(TAG, "onZjAdVideoCached");

                isFullScreenVideoRequesting = false;
                cancel();

                if (fullScreenVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdVideoCached");
                    fullScreenVideoEventSink.success(result);
                }

                zjFullScreenVideoAd.showAd();
            }

            @Override
            public void onZjAdClosed() {
                Log.e(TAG, "onZjAdClosed");

                isFullScreenVideoRequesting = false;

                if (fullScreenVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClose");
                    fullScreenVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdShow() {
                Log.e(TAG, "onZjAdShow");

                if (fullScreenVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdShow");
                    fullScreenVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdClicked() {
                Log.e(TAG, "onZjAdClicked");

                if (fullScreenVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClick");
                    fullScreenVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdVideoComplete() {
                Log.e(TAG, "onZjAdVideoComplete");

                if (fullScreenVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdVideoComplete");
                    fullScreenVideoEventSink.success(result);
                }
            }

            @Override
            public void onZjAdError(ZjAdError zjAdError) {
                Log.d(TAG, "onZjAdError[" + zjAdError.getErrorCode() + "-" + zjAdError.getErrorMsg() + "]");

                isFullScreenVideoRequesting = false;
                cancel();

                if (fullScreenVideoEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdError");
                    result.put("code", zjAdError.getErrorCode());
                    result.put("message", zjAdError.getErrorMsg());
                    fullScreenVideoEventSink.success(result);
                }
            }
        });
        zjFullScreenVideoAd.loadAd();
    }

    // EventSink
    EventChannel.EventSink h5AdEventSink;

    /**
     * 加载H5广告
     *
     * @param posId     广告位ID
     * @param userId    用户ID
     * @param username  用户名
     * @param avatarUrl 头像URL
     */
    private void loadH5Ad(String posId, String userId, String username, String avatarUrl) {
        ZjUser zjuser = new ZjUser(userId, username, avatarUrl, 1000);

        new ZjH5Ad(activity, zjuser, new ZjH5ContentListener() {
            @Override
            public void onIntegralNotEnough(ZjUser zjUser, int needIntegral) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onIntegralNotEnough");
                    result.put("userId", zjUser.userID);
                    result.put("needIntegral", needIntegral);
                    h5AdEventSink.success(result);
                }
            }

            @Override
            public void onIntegralExpend(ZjUser zjUser, int expendIntegral) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onIntegralExpend");
                    result.put("userId", zjUser.userID);
                    result.put("expendIntegral", expendIntegral);
                    h5AdEventSink.success(result);
                }
            }

            @Override
            public void onFinishTasks(ZjUser zjUser, int finishTasks) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onFinishTasks");
                    result.put("userId", zjUser.userID);
                    result.put("finishTasks", finishTasks);
                    h5AdEventSink.success(result);
                }
            }

            @Override
            public void onGameExit(ZjUser zjUser) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onGameExit");
                    result.put("userId", zjUser.userID);
                    h5AdEventSink.success(result);
                    h5AdEventSink.endOfStream();
                }
            }

            @Override
            public void onZjAdReward(ZjUser zjUser, int rewardIntegral) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdRewardFinish");
                    result.put("userId", zjUser.userID);
                    result.put("rewardIntegral", rewardIntegral);
                    h5AdEventSink.success(result);
                }
            }

            @Override
            public void onZjAdReward(String s) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdReward");
                    h5AdEventSink.success(result);
                }
            }

            @Override
            public void onZjAdLoaded(String s) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdLoaded");
                    h5AdEventSink.success(result);
                }
            }

            @Override
            public void onZjAdTradeId(String tradeId) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdTradeId");
                    result.put("tradeId", tradeId);
                    h5AdEventSink.success(result);
                }
            }

            @Override
            public void onZjAdClick() {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClick");
                    h5AdEventSink.success(result);
                }
            }

            @Override
            public void onZjUserBehavior(String behavior) {
                if (h5AdEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjUserBehavior");
                    result.put("behavior", behavior);
                    h5AdEventSink.success(result);
                }
            }
        }, posId);
    }

    /**
     * 原生Activity加载视频内容
     *
     * @param posId 广告位ID
     */
    private void startContent(String posId) {
        Intent intent = new Intent(this.activity, ZjContentActivity.class);
        intent.putExtra("posId", posId);
        this.activity.startActivity(intent);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        pluginBinding = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        initializePlugin(binding.getActivity(), pluginBinding.getBinaryMessenger(), pluginBinding.getPlatformViewRegistry());
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        activity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        initializePlugin(binding.getActivity(), pluginBinding.getBinaryMessenger(), pluginBinding.getPlatformViewRegistry());
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }

}
