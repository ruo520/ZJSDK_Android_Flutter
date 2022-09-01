package com.zj.zjsdk.plugin;

import android.content.Context;

public class ZjUITool {

    private static float density = -1;

    public static int toPx(Context context, float dp) {
        if (density == -1) {
            try {
                density = context.getResources().getDisplayMetrics().density;
            } catch (Throwable t) {
                t.printStackTrace();
            }
        }
        return Math.max(-1, (int) (dp * (density <= 0 ? 1 : density) + 0.5f));
    }

}
