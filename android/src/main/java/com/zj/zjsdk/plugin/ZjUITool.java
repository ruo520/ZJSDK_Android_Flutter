package com.zj.zjsdk.plugin;

import android.content.Context;

public class ZjUITool {

    private static float density = -1;
    private static float screenWidthPx = -1;
    private static float screenHeightPx = -1;

    public static int toPx(Context context, float dp) {
        if (density == -1) {
            try {
                density = context.getResources().getDisplayMetrics().density;
            } catch (Throwable t) {
                t.printStackTrace();
            }
        }
        if (screenWidthPx == -1) {
            try {
                screenWidthPx = context.getResources().getDisplayMetrics().widthPixels;
            } catch (Throwable t) {
                t.printStackTrace();
            }
        }
        if (screenHeightPx == -1) {
            try {
                screenHeightPx = context.getResources().getDisplayMetrics().heightPixels;
            } catch (Throwable t) {
                t.printStackTrace();
            }
        }
        int value = Math.max(-1, (int) (dp * (density <= 0 ? 1 : density) + 0.5f));
        if (value > screenWidthPx || value > screenHeightPx) {
            value = -1;
        }
        return value;
    }

}
