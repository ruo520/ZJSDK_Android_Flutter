# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class com.zj.zjsdk.core.config.ZjAdConfig {*;}
-keep class com.zj.zjsdk.core.db.ZjSdkDbManager {*;}
-keep class com.zj.zjsdk.core.DeviceId.ZjDeviceId {*;}
-keep class com.zj.zjsdk.ZjSdk {*;}
-keep class com.zj.zjsdk.core.Provider.ZjFileProvider {*;}
-keep class com.zj.zjsdk.ad.** { *; }
-keep class com.zj.zjsdk.core.config.ZjSdkConfig { *; }
-keep class com.zj.zjsdk.ZjSdkManager {*;}
-keep interface com.zj.zjsdk.ZjH5ContentListener {*;}
-keep class com.zj.zjsdk.ZjUser {*;}
-keep class com.zj.zjsdk.ZjGameActivity {*;}
-keep class com.zj.zjsdk.ZjGameSpaceActivity {*;}
-keep class com.zj.zjsdk.js.ZjJSSdk  {
                                        public <methods>;
}
-keep class com.zj.zjsdk.js.ZjJSAppSdk   {
                                                                               public <methods>;
                                       }
-keep class com.zj.zjsdk.js.ZjJSAdSdk   {
                                                                              public <methods>;
                                      }
-keep class com.bun.supplier.IIdentifierListener { *; }

#V1.3.0.0及以上版本
-ignorewarnings
-dontwarn com.lechuan.midunovel.**
-keep class com.lechuan.midunovel.** { *; }

-keep class com.qq.e.** { *; }
-keep interface com.qq.e.** { *; }
-keep class com.qq.e.** {
    public protected *;
}
-keep class android.support.v4.**{
    public *;
}
-keep class android.support.v7.**{
    public *;
}
#
-keep class com.bytedance.sdk.openadsdk.** { *; }
-keep public interface com.bytedance.sdk.openadsdk.downloadnew.** {*;}
-keep class com.pgl.sys.ces.* {*;}


-keep class org.chromium.** {*;}
-keep class org.chromium.** { *; }
-keep class aegon.chrome.** { *; }
-keep class com.kwai.**{ *; }
-keep class com.kwad.**{ *; }
-keepclasseswithmembernames class * {
native <methods>;
}
-dontwarn com.kwai.**
-dontwarn com.kwad.**
-dontwarn com.ksad.**
-dontwarn aegon.chrome.**

-keep class com.netease.nis.sdkwrapper.Utils {*;}
-keep class com.bun.supplier.IIdentifierListener { *; }
-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.vs.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
-keep class com.bun.lib.**{*;}
-keep class com.bun.miitmdid.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class org.json.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {public <methods>;}