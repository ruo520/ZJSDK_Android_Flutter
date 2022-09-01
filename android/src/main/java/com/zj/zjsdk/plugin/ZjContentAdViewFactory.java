package com.zj.zjsdk.plugin;

import android.app.Activity;
import android.content.Context;

import androidx.fragment.app.FragmentActivity;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class ZjContentAdViewFactory extends PlatformViewFactory {

    private final BinaryMessenger messenger;
    public Activity mActivity;
    ZjContentAdView contentView;

    public ZjContentAdViewFactory(BinaryMessenger messenger, Activity activity) {
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
        if (null == contentView) {
            contentView = new ZjContentAdView(context, (FragmentActivity) mActivity, messenger, viewId, posId, width, height);
        } else {
            contentView.updateId(messenger, viewId);
        }
        return contentView;
    }

}
