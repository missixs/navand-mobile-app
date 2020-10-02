package com.missixs.navand;

import android.content.Context;
import androidx.annotation.NonNull;
import android.telephony.TelephonyManager;
import android.telephony.PhoneStateListener;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CALL_CHANNEL = "com.missixs.navand/call";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant pluginSupport = new GeneratedPluginRegistrant();
        pluginSupport.registerWith(flutterEngine);

        new EventChannel(flutterEngine.getDartExecutor(), CALL_CHANNEL).setStreamHandler(
                new StreamHandler() {
                    private TelephonyManager telephonyManager;
                    private PhoneStateListener callStateListener;

                    @Override
                    public void onListen(Object arguments, EventSink events) {

                        telephonyManager = (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);

                        callStateListener = new PhoneStateListener() {
                            public void onCallStateChanged(int state, String incomingNumber) {
                                if (state == TelephonyManager.CALL_STATE_RINGING) {
                                    events.success("RING Ring!");
                                }
                                //else if (state == TelephonyManager.CALL_STATE_IDLE)
                                    //events.success("IT IS Idle ! (" + incomingNumber + "!");
                            }
                        };
                        telephonyManager.listen(callStateListener, PhoneStateListener.LISTEN_CALL_STATE);

                    }

                    @Override
                    public void onCancel(Object arguments) {
                        if (telephonyManager != null && callStateListener != null) {
                            telephonyManager.listen(callStateListener, PhoneStateListener.LISTEN_NONE);
                            telephonyManager = null;
                            callStateListener = null;
                        }
//                        unregisterReceiver(chargingStateChangeReceiver);
//                        chargingStateChangeReceiver = null;
                    }
                }
        );
    }

}

