package com.zj.zjsdk.plugin;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.zj.zjsdk.ad.ZjAdError;
import com.zj.zjsdk.ad.ZjSplashAd;
import com.zj.zjsdk.ad.ZjSplashAdListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.platform.PlatformView;

public class ZjSplashAdView implements PlatformView {

    private static final String TAG = "ZjSplashAdView";

    private final View mView;
    private final ViewGroup container;
    private EventChannel.EventSink mEventSink;

    public ZjSplashAdView(Context context, final Activity activity, BinaryMessenger messenger, int id, final String posId, int width, int height) {
        EventChannel eventChannel = new EventChannel(messenger, "flutter_zjsdk_plugin/splash_event_" + id);
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                Log.d(TAG, "onListen");
                mEventSink = eventSink;
            }

            @Override
            public void onCancel(Object o) {
                Log.d(TAG, "onCancel");
            }
        });

        mView = new FrameLayout(context);
        mView.setLayoutParams(new FrameLayout.LayoutParams(ZjUITool.toPx(context, width), ZjUITool.toPx(context, height)));

        container = new FrameLayout(context);
        container.setLayoutParams(new FrameLayout.LayoutParams(-1, -1));
        ((ViewGroup) mView).addView(container);

        mView.post(new Runnable() {
            @Override
            public void run() {
                loadSplash(activity, posId);
            }
        });
    }

    private void loadSplash(Activity activity, String posId) {
        ZjSplashAd zjSplashAd = new ZjSplashAd(activity, new ZjSplashAdListener() {

            @Override
            public void onZjAdLoaded() {
                Log.d(TAG, "onZjAdLoaded");

                if (mEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdLoaded");
                    mEventSink.success(result);
                }
            }

            @Override
            public void onZjAdLoadTimeOut() {
                Log.d(TAG, "onZjAdLoadTimeOut");

                if (mEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdError");
                    result.put("code", "0");
                    result.put("message", "onZjAdLoadTimeOut");
                    mEventSink.success(result);
                    mEventSink.endOfStream();
                }
            }

            @Override
            public void onZjAdShow() {
                Log.d(TAG, "onZjAdShow");

                if (mEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdShow");
                    mEventSink.success(result);
                }
            }

            @Override
            public void onZjAdClicked() {
                Log.d(TAG, "onZjAdClicked");

                if (mEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClicked");
                    mEventSink.success(result);
                }
            }

            @Override
            public void onZjAdTickOver() {
                Log.d(TAG, "onZjAdTickOver");

                if (mEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClosed");
                    mEventSink.success(result);
                    mEventSink.endOfStream();
                }
            }

            @Override
            public void onZjAdDismissed() {
                Log.d(TAG, "onZjAdDismissed");

                if (mEventSink != null) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("event", "onZjAdClosed");
                    mEventSink.success(result);
                    mEventSink.endOfStream();
                }
            }

            @Override
            public void onZjAdError(final ZjAdError adError) {
                Log.d(TAG, "onZjAdError[" + adError.getErrorCode() + "-" + adError.getErrorMsg() + "]");

                if (mEventSink != null) {
                    container.post(new Runnable() {
                        @Override
                        public void run() {
                            if (mEventSink != null) {
                                Map<String, Object> result = new HashMap<>();
                                result.put("event", "onZjAdError");
                                result.put("code", adError.getErrorCode());
                                result.put("message", adError.getErrorMsg());
                                mEventSink.success(result);
                                mEventSink.endOfStream();
                            }
                        }
                    });
                }
            }
        }, posId, 5);

        zjSplashAd.fetchAndShowIn(container);
    }

    @Override
    public View getView() {
        return mView;
    }

    @Override
    public void dispose() {
        Log.e(TAG, "dispose");
    }

}
