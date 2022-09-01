package com.zj.zjsdk.plugin;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.zj.zjsdk.ad.ZjAdError;
import com.zj.zjsdk.ad.ZjBannerAd;
import com.zj.zjsdk.ad.ZjBannerAdListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.platform.PlatformView;

public class ZjBannerAdView implements PlatformView {

    private final ViewGroup container;
    ZjBannerAd bannerAd;
    private final Activity activity;
    private EventChannel.EventSink mEventSink;

    public ZjBannerAdView(Context context, Activity activity, BinaryMessenger messenger, int id, String posId, int width, int height) {

        EventChannel eventChannel = new EventChannel(messenger, "flutter_zjsdk_plugin/banner_event_" + id);
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                mEventSink = eventSink;
            }

            @Override
            public void onCancel(Object o) {
            }
        });

        this.activity = activity;
        this.container = new FrameLayout(context);
        container.setLayoutParams(new FrameLayout.LayoutParams(ZjUITool.toPx(context, width), ZjUITool.toPx(context, height)));

        loadAd(posId);
    }

    private void loadAd(String posId) {
        bannerAd = new ZjBannerAd(activity, posId, new ZjBannerAdListener() {
            @Override
            public void onZjAdLoaded() {
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onZjAdLoaded");
                mEventSink.success(result);
            }

            @Override
            public void onZjAdShow() {
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onZjAdShow");
                mEventSink.success(result);
            }

            @Override
            public void onZjAdClicked() {
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onZjAdClicked");
                mEventSink.success(result);
            }

            @Override
            public void onZjAdClosed() {
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onZjAdClosed");
                mEventSink.success(result);
                mEventSink.endOfStream();
            }

            @Override
            public void onZjAdError(ZjAdError zjAdError) {
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onZjAdError");
                result.put("code", zjAdError.getErrorCode());
                result.put("message", zjAdError.getErrorMsg());
                mEventSink.success(result);
                mEventSink.endOfStream();
            }
        });
        bannerAd.setBannerContainer(container);
        bannerAd.setRefresh(0);
        bannerAd.loadAD();
    }

    @Override
    public View getView() {
        return container;
    }

    @Override
    public void dispose() {
        if (container != null) {
            container.removeAllViews();
        }
    }

}
