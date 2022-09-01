package com.zj.zjsdk.example;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;

import androidx.fragment.app.FragmentActivity;

import com.zj.zjsdk.ad.ZjAdError;
import com.zj.zjsdk.ad.ZjSplashAd;
import com.zj.zjsdk.ad.ZjSplashAdListener;

/**
 * 原生开屏页面，在请求展示开屏广告之后跳转到Flutter主页面
 */
public class SplashActivity extends FragmentActivity implements ZjSplashAdListener {

    private static final String TAG = SplashActivity.class.getSimpleName();

    // 用于判断广告点击跳转
    private boolean isPause;
    private boolean isAdClicked;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);
        // 广告容器
        ViewGroup container = this.findViewById(R.id.splash_container);
        // 刘海屏全屏展示开屏广告
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            WindowManager.LayoutParams layoutParams = getWindow().getAttributes();
            layoutParams.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
            getWindow().setAttributes(layoutParams);
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
        }

        // 如果启动图停留时间过短，返回未找到广告位，建议延时调用开屏广告
        container.postDelayed(() -> {
            // 请求开屏广告
            ZjSplashAd splashAd = new ZjSplashAd(this, this, Constants.SPLASH_POS_ID, 5);
            splashAd.fetchAndShowIn(container);
        }, 1000);
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (isAdClicked) {
            isPause = true;
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (isPause) {
            next();
        }
    }

    @Override
    public void onZjAdClicked() {
        showStatus("点击广告");
        isAdClicked = true;
    }

    @Override
    public void onZjAdLoaded() {
        showStatus("广告加载成功");
    }

    @Override
    public void onZjAdLoadTimeOut() {
        showStatus("广告请求超时");
        next();
    }

    @Override
    public void onZjAdShow() {
        showStatus("广告展示");
    }

    @Override
    public void onZjAdTickOver() {
        showStatus("广告倒计时结束");
        if (!isPause) {
            next();
        }
    }

    @Override
    public void onZjAdDismissed() {
        showStatus("广告被关闭");
        if (!isPause) {
            next();
        }
    }

    @Override
    public void onZjAdError(ZjAdError error) {
        showStatus("广告请求失败[" + error.getErrorCode() + "-" + error.getErrorMsg() + "]");
        next();
    }

    /**
     * 跳转到Flutter主页面
     */
    private void next() {
        startActivity(new Intent(this, MainActivity.class));
        SplashActivity.this.finish();
    }

    /**
     * 打印日志
     */
    private void showStatus(String msg) {
        Log.i(TAG, msg);
    }

    /**
     * 开屏页一定要禁止用户对返回按钮的控制，否则将可能导致用户手动退出了App而广告无法正常曝光和计费
     */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK || keyCode == KeyEvent.KEYCODE_HOME)
            return true;
        return super.onKeyDown(keyCode, event);
    }

}