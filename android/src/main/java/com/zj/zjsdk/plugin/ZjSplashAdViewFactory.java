package com.zj.zjsdk.plugin;

import android.app.Activity;
import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class ZjSplashAdViewFactory extends PlatformViewFactory {

    private final BinaryMessenger messenger;
    public Activity mActivity;

    public ZjSplashAdViewFactory(BinaryMessenger messenger, Activity activity) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.mActivity = activity;
    }

    @SuppressWarnings("unchecked")
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        Map<String, Object> map = (Map<String, Object>) args;
        String posId = (String) map.get("posId");
        float width = ((Double) map.get("width")).floatValue();
        float height = ((Double) map.get("height")).floatValue();
        return new ZjSplashAdView(context, mActivity, messenger, viewId, posId, (int) width, (int) height);
    }

}
