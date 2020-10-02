import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:navand/utils/storage.dart';
import 'package:navand/utils/network.dart';
import 'package:navand/utils/formUtils.dart';

class AppState extends ChangeNotifier {
  String token = '';
  bool enable = true;
  TokenStorage storage = new TokenStorage();
  NetworkManager networkManager = new NetworkManager();

  AppState(BuildContext context) {
    storage.readToken().then((String localToken) {
      token = localToken;
      print('Constructed app state');
    });
  }

  void onCallReceive() {
    print("Sending Notification");
    print("Token is $token");
    if (enable) {
      networkManager.sendNotification(
          token, 'Ring Ring 📞 ', 'Your phone is ringing, darling🌹');
    } else {
      print("App is disabled,I'm not sending");
    }
  }

  Future<void> onSendTestMessage(
      BuildContext context, String title, String text) async {
    await networkManager.sendNotification(token, title, text);
    final snackBar = SnackBar(content: Text('Successfully sent'));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void onNewTokenClicked() {
    token = generateToken();
    storage.writeToken(token).then((value) {
      print('wrote to New Token to file');
    });
    // Write the variable as a string to the file.
    notifyListeners();
  }

  void toggleEnable() {
    enable = !enable;
    print('Enbl $enable');
    notifyListeners();
  }

  // AppState(){super();}

}

/**
    /flutter ( 6550): Sending Notification
    I/flutter ( 6550): Token is ba659b80-025c-11eb-b269-216170931f30
    I/flutter ( 6550): Sending Notification
    I/flutter ( 6550): Call 0 received Baby RING Ring!

    ════════ Exception caught by services library ══════════════════════════════════════════════════════
    The following _CompileTimeError was thrown during a platform message callback:
    Unimplemented handling of missing static target

    When the exception was thrown, this was the stack:
    #0      WidgetsBinding.handleAppLifecycleStateChanged (package:flutter/src/widgets/binding.dart:704:16)
    #1      ServicesBinding._handleLifecycleMessage (package:flutter/src/services/binding.dart:192:5)
    #2      BasicMessageChannel.setMessageHandler.<anonymous closure> (package:flutter/src/services/platform_channel.dart:74:49)
    #3      _DefaultBinaryMessenger.handlePlatformMessage (package:flutter/src/services/binding.dart:283:33)
    #4      _invoke3.<anonymous closure> (dart:ui/hooks.dart:280:15)
    ...
    ════════════════════════════════════════════════════════════════════════════════════════════════════
    E/flutter ( 6550): [ERROR:flutter/lib/ui/ui_dart_state.cc(177)] Unhandled Exception: SocketException: Failed host lookup: '5ef6cb51-3913-416a-891b-637f5068d31d.pushnotifications.pusher.com' (OS Error: No address associated with hostname, errno = 7)
    E/flutter ( 6550):
    I/art     ( 6550): Background partial concurrent mark sweep GC freed 181788(6MB) AllocSpace objects, 0(0B) LOS objects, 44% free, 9MB/17MB, paused 18.304ms total 60.016ms

    ════════ Exception caught by services library ══════════════════════════════════════════════════════
    The following _CompileTimeError was thrown during a platform message callback:
    Unimplemented handling of missing static target

    When the exception was thrown, this was the stack:
    #0      WidgetsBinding.handleAppLifecycleStateChanged (package:flutter/src/widgets/binding.dart:704:16)
    #1      ServicesBinding._handleLifecycleMessage (package:flutter/src/services/binding.dart:192:5)
    #2      BasicMessageChannel.setMessageHandler.<anonymous closure> (package:flutter/src/services/platform_channel.dart:74:49)
    #3      _DefaultBinaryMessenger.handlePlatformMessage (package:flutter/src/services/binding.dart:283:33)
    #4      _invoke3.<anonymous closure> (dart:ui/hooks.dart:280:15)
    ...
    ════════════════════════════════════════════════════════════════════════════════════════════════════


 **/
