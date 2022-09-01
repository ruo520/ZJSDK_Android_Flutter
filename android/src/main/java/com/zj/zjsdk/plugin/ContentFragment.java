package com.zj.zjsdk.plugin;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.kwad.sdk.api.KsContentPage;
import com.zj.zjsdk.ad.ZjAdError;
import com.zj.zjsdk.ad.ZjContentAd;
import com.zj.zjsdk.ad.ZjContentAdListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;

public class ContentFragment extends Fragment {

    private String posId;
    private EventChannel.EventSink mEventSink;
    private ZjContentAd contentAd;
    private FrameLayout mView;

    void setEventSink(EventChannel.EventSink eventSink) {
        this.mEventSink = eventSink;
    }

    void setPosId(String posId) {
        this.posId = posId;
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        mView = new FrameLayout(getContext());
        mView.setId(View.generateViewId());
        return mView;
    }

    void loadContent() {

        contentAd = new ZjContentAd(requireActivity(), new ZjContentAdListener() {
            @Override
            public void onZjAdError(ZjAdError adError) {
                Log.d("TAG", "onZjAdError[" + adError.getErrorCode() + "-" + adError.getErrorCode() + "]");
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onZjAdError");
                result.put("code", adError.getErrorCode());
                result.put("message", adError.getErrorMsg());
                if (mEventSink != null) {
                    mEventSink.success(result);
                    mEventSink.endOfStream();
                }
            }

            @Override
            public void onPageEnter(KsContentPage.ContentItem contentItem) {
                Map<String, Object> result = new HashMap<>();
//                      result.put("contentItem",contentItem);
                result.put("event", "onPageEnter");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }

            @Override
            public void onPageResume(KsContentPage.ContentItem contentItem) {
                Map<String, Object> result = new HashMap<>();
//                      result.put("contentItem",contentItem);
                result.put("event", "onPageResume");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }

            @Override
            public void onPagePause(KsContentPage.ContentItem contentItem) {
                Map<String, Object> result = new HashMap<>();
//                      result.put("contentItem",contentItem);
                result.put("event", "onPagePause");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }

            @Override
            public void onPageLeave(KsContentPage.ContentItem contentItem) {
                Map<String, Object> result = new HashMap<>();
//                      result.put("contentItem",contentItem);
                result.put("event", "onPageLeave");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }

            @Override
            public void onVideoPlayStart(KsContentPage.ContentItem contentItem) {
                Map<String, Object> result = new HashMap<>();
                result.put("event", "onVideoPlayStart");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }

            @Override
            public void onVideoPlayPaused(KsContentPage.ContentItem contentItem) {
                Map<String, Object> result = new HashMap<>();
//                      result.put("contentItem",contentItem);
                result.put("event", "onVideoPlayPaused");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }

            @Override
            public void onVideoPlayResume(KsContentPage.ContentItem contentItem) {
                Map<String, Object> result = new HashMap<>();
//                      result.put("contentItem",contentItem);
                result.put("event", "onVideoPlayResume");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }

            @Override
            public void onVideoPlayCompleted(KsContentPage.ContentItem contentItem) {
                Map<String, Object> result = new HashMap<>();
//                      result.put("contentItem",contentItem);
                result.put("event", "onVideoPlayCompleted");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }

            @Override
            public void onVideoPlayError(KsContentPage.ContentItem contentItem, int i, int i1) {
                Map<String, Object> result = new HashMap<>();
//                      result.put("contentItem",contentItem);
                result.put("event", "onVideoPlayError");
                result.put("id", contentItem.id);
                if (mEventSink != null) {
                    mEventSink.success(result);
                }
            }
        }, posId);
    }

    public void show() {
        if (contentAd != null) {
            contentAd.showAd(mView.getId(), getChildFragmentManager());
        }
    }

    public void hide() {
        if (contentAd != null) {
            contentAd.hideAd();
        }
    }

    public void dispose() {
        try {
            contentAd.hideAd();
            contentAd = null;
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }

}