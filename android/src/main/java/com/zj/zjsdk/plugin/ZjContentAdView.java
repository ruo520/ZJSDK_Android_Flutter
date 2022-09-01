package com.zj.zjsdk.plugin;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.FragmentActivity;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class ZjContentAdView implements PlatformView, MethodChannel.MethodCallHandler {

    private static final String TAG = "ZjContentAdView";

    private final ViewGroup container;
    private EventChannel.EventSink mEventSink;
    private final ContentFragment fragment;

    public ZjContentAdView(Context context, final FragmentActivity activity, BinaryMessenger messenger, int id, final String posId, float width, float height) {
        updateId(messenger, id);
        container = (ViewGroup) LayoutInflater.from(activity).inflate(R.layout.zj_layout_content, null, false);
        container.setLayoutParams(new ViewGroup.LayoutParams(ZjUITool.toPx(context, width), ZjUITool.toPx(context, height)));
        fragment = (ContentFragment) (activity).getSupportFragmentManager().findFragmentById(R.id.zj_content_fragment_stub);
        assert fragment != null;
        fragment.setEventSink(mEventSink);
        fragment.setPosId(posId);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Log.e(TAG, "onMethodCall:" + call.method);
        switch (call.method) {
            case "hideAd":
                if (fragment != null) {
                    fragment.hide();
                }
                break;
            case "showAd":
                if (fragment != null) {
                    fragment.show();
                }
                break;
        }
    }

    @Override
    public View getView() {
        return container;
    }

    @Override
    public void onFlutterViewAttached(@NonNull View flutterView) {
        container.post(new Runnable() {
            @Override
            public void run() {
                if (fragment != null) {
                    fragment.loadContent();
                    fragment.show();
                }
            }
        });
    }

    @Override
    public void dispose() {
        Log.e(TAG, "dispose");
        fragment.dispose();
    }

    public void updateId(BinaryMessenger messenger, int viewId) {
        MethodChannel methodChannel = new MethodChannel(messenger, "flutter_zjsdk_plugin/content_video_method_" + viewId);
        methodChannel.setMethodCallHandler(this);
        EventChannel eventChannel = new EventChannel(messenger, "flutter_zjsdk_plugin/content_video_event_" + viewId);
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                mEventSink = eventSink;
            }

            @Override
            public void onCancel(Object o) {
            }
        });
    }

}
