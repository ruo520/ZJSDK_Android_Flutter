///*****************
/// 广告回调
///*****************

/// 正常回调
typedef AdCallback0 = void Function();
typedef AdCallback1 = void Function(String arg);
typedef AdCallback2 = void Function(String arg0, int arg1);

/// 错误回调
/// code -> 错误码 | message -> 错误信息
typedef AdErrorCallback = void Function(int code, String? message);
