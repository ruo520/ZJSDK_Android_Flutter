package com.zj.zjsdk.example;

import androidx.annotation.NonNull;

import com.zj.zjsdk.plugin.ZjSdkPlugin;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterFragmentActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        // 注册广告插件
        flutterEngine.getPlugins().add(new ZjSdkPlugin());
    }

}
