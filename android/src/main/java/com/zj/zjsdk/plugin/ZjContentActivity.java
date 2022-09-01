package com.zj.zjsdk.plugin;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;

import androidx.fragment.app.FragmentActivity;

import com.kwad.sdk.api.KsContentPage;
import com.zj.zjsdk.ad.ZjAdError;
import com.zj.zjsdk.ad.ZjContentAd;
import com.zj.zjsdk.ad.ZjContentAdListener;

public class ZjContentActivity extends FragmentActivity {

    private static final String TAG = "ZjContentActivity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.zj_activity_content);
        // 刘海屏全屏展示开屏广告
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            WindowManager.LayoutParams layoutParams = getWindow().getAttributes();
            layoutParams.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
            getWindow().setAttributes(layoutParams);
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
        }
        Intent intent = getIntent();
        String posId = intent.getStringExtra("posId");

        ZjContentAd contentAd = new ZjContentAd(this, new ZjContentAdListener() {
            @Override
            public void onZjAdError(ZjAdError error) {
                Log.d(TAG, "onZjAdError[" + error.getErrorCode() + "-" + error.getErrorMsg() + "]");
            }

            @Override
            public void onPageEnter(KsContentPage.ContentItem contentItem) {

            }

            @Override
            public void onPageResume(KsContentPage.ContentItem contentItem) {

            }

            @Override
            public void onPagePause(KsContentPage.ContentItem contentItem) {

            }

            @Override
            public void onPageLeave(KsContentPage.ContentItem contentItem) {

            }

            @Override
            public void onVideoPlayStart(KsContentPage.ContentItem contentItem) {

            }

            @Override
            public void onVideoPlayPaused(KsContentPage.ContentItem contentItem) {

            }

            @Override
            public void onVideoPlayResume(KsContentPage.ContentItem contentItem) {

            }

            @Override
            public void onVideoPlayCompleted(KsContentPage.ContentItem contentItem) {

            }

            @Override
            public void onVideoPlayError(KsContentPage.ContentItem contentItem, int i, int i1) {

            }


        }, posId);
        contentAd.showAd(R.id.main_frame_layout);
    }

}
