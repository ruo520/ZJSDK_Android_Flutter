package com.zj.zjsdk.plugin;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.zj.zjsdk.ad.ZjAdError;
import com.zj.zjsdk.ad.ZjSize;
import com.zj.zjsdk.ad.express.ZjExpressFeedFullVideo;
import com.zj.zjsdk.ad.express.ZjExpressFeedFullVideoAd;
import com.zj.zjsdk.ad.express.ZjExpressFeedFullVideoListener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.platform.PlatformView;

public class ZjExpressVideoAdView implements PlatformView {

    private static final String TAG = "ZjExpressVideoAdView";

    private final ViewGroup container;

    private EventChannel.EventSink mEventSink;

    public ZjExpressVideoAdView(Context context, Activity activity, BinaryMessenger messenger, int id, String posId, int width, int height) {
        EventChannel eventChannel = new EventChannel(messenger, "flutter_zjsdk_plugin/express_video_event_" + id);
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

        container = new FrameLayout(context);
        container.setLayoutParams(new FrameLayout.LayoutParams(ZjUITool.toPx(context, width), ZjUITool.toPx(context, height)));
        loadAd(activity, posId, width, height);
    }

    private void loadAd(Activity activity, String posId, int width, int height) {
        ZjExpressFeedFullVideo zjExpressFullVideoFeed = new ZjExpressFeedFullVideo(activity, posId, new ZjSize(ZjUITool.toPx(activity, width), ZjUITool.toPx(activity, height)), new ZjExpressFeedFullVideoListener() {

            @Override
            public void onZjAdError(ZjAdError zjAdError) {
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onZjAdError");
                result.put("code", zjAdError.getErrorCode());
                result.put("message", zjAdError.getErrorMsg());
                if (mEventSink != null) {
                    mEventSink.success(result);
                    mEventSink.endOfStream();
                }
            }

            @Override
            public void onZjFeedFullVideoLoad(List<ZjExpressFeedFullVideoAd> list) {
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onZjFeedFullVideoLoad");

                if (list != null && list.size() > 0) {
                    result.put("size", String.valueOf(list.size()));
                    ZjExpressFeedFullVideoAd ad = list.get(0);
                    ad.setExpressInteractionListener(new ZjExpressFeedFullVideoAd.FeedFullVideoAdInteractionListener() {
                        @Override
                        public void onAdClicked(View view, int i) {
                            Map<String, Object> result = new HashMap<>();
                            result.put("event", "onZjAdClicked");
                            if (mEventSink != null) {
                                mEventSink.success(result);
                            }
                        }

                        @Override
                        public void onAdShow(View view, int i) {
                            Map<String, Object> result = new HashMap<>();
                            result.put("event", "onZjAdShow");
                            if (mEventSink != null) {
                                mEventSink.success(result);
                            }
                        }

                        @Override
                        public void onRenderSuccess(View view, float v, float v1) {
                            Map<String, Object> result = new HashMap<>();
                            result.put("event", "onRenderSuccess");
                            if (mEventSink != null) {
                                mEventSink.success(result);
                            }
                        }

                        @Override
                        public void onRenderFail(View view, ZjAdError zjAdError) {
                            Map<String, Object> result = new HashMap<>();
                            result.put("event", "onRenderFail");
                            result.put("code", zjAdError.getErrorCode());
                            result.put("message", zjAdError.getErrorMsg());
                            if (mEventSink != null) {
                                mEventSink.success(result);
                                mEventSink.endOfStream();
                            }
                        }
                    });
                    ad.render(container);
                } else {
                    result.put("size", "0");
                }

                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }
        });
        zjExpressFullVideoFeed.loadAd();
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
