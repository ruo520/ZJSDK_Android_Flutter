package com.zj.zjsdk.example;

import com.zj.zjsdk.ZjSdk;

import io.flutter.app.FlutterApplication;


public class MainApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        // 初始化SDK，填入媒体ID
        ZjSdk.init(this, Constants.APP_ID);
    }

}
