package com.missixs.navand;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

abstract class TimeCallReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Log.e("NAVAND","Im called Baby!");
    }
}

public class TimeReceiver extends TimeCallReceiver {

}