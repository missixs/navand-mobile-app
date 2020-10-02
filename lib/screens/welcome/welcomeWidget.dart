import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:navand/models/appState.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:fluttericon/typicons_icons.dart';

class WelcomeWidget extends StatelessWidget {
  WelcomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState state, Widget child) {
        String enableText = state.enable ? 'Enabled' : 'Disabled';
        Color color = state.enable ? Colors.green[600] : Colors.red;
        return Column(
          children: [
            Flexible(
              flex: 6,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: AvatarGlow(
                  glowColor: color,
                  endRadius: 120.0,
                  duration: Duration(milliseconds: 3000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: IconButton(
                      icon: Icon(
                        state.enable
                            ? Icons.power_settings_new_outlined
                            : Icons.power_settings_new_sharp,
                        color: color,
                      ),
                      iconSize: 90,
                      onPressed: () {
                        print('Pressed!');
                        state.toggleEnable();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: RichText(
                    // textScaleFactor: 1.5,

                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                          text: enableText,
                        ),
                        WidgetSpan(
                          child: Icon(
                            state.enable
                                ? Typicons.ok_outline
                                : Typicons.cancel_outline,
                            color: color,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage('images/v.gif'),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
