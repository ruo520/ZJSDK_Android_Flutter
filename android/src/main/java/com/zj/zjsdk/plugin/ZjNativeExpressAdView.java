package com.zj.zjsdk.plugin;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.zj.zjsdk.ad.ZjAdError;
import com.zj.zjsdk.ad.ZjNativeExpressAd;
import com.zj.zjsdk.ad.ZjNativeExpressAdListener;
import com.zj.zjsdk.ad.ZjSize;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.platform.PlatformView;

public class ZjNativeExpressAdView implements PlatformView {

    private static final String TAG = "ZjNativeExpressAdView";

    private final ViewGroup container;
    private EventChannel.EventSink mEventSink;

    public ZjNativeExpressAdView(Context context, Activity activity, BinaryMessenger messenger, int id, String posId, int width, int height) {

        EventChannel eventChannel = new EventChannel(messenger, "flutter_zjsdk_plugin/native_express_event_" + id);
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                mEventSink = eventSink;
            }

            @Override
            public void onCancel(Object o) {
            }
        });

        container = new FrameLayout(context);
        container.setLayoutParams(new FrameLayout.LayoutParams(ZjUITool.toPx(context, width), ZjUITool.toPx(context, height)));

        loadAd(activity, posId, width, height);
    }

    private void loadAd(Activity activity, String posId, int width, int height) {

        ZjNativeExpressAd expressAd = new ZjNativeExpressAd(activity, posId, new ZjNativeExpressAdListener() {
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
        }, container);
        expressAd.setSize(new ZjSize(width, height));
        expressAd.loadAd();
    }

    @Override
    public View getView() {
        return container;
    }

    @Override
    public void dispose() {
        Log.e(TAG, "dispose");
    }

}
