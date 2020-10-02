import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:navand/models/appState.dart';
import 'package:navand/screens/testMessage/testMessageWidget.dart';

class RenewButton extends StatefulWidget {
  @override
  RenewButtonState createState() => RenewButtonState();
}

class RenewButtonState extends State<RenewButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  final int animationDuration = 2; //in seconds

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(seconds: animationDuration));
    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        Provider.of<AppState>(context, listen: false).onNewTokenClicked();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        controller.forward();
        if (controller.status == AnimationStatus.completed) {
          // controller.reverse();
        }
      },
      onTapUp: (_) {
        // controller.reverse();

        if (controller.status == AnimationStatus.forward ||
            controller.status == AnimationStatus.completed) {
          controller.reverse();
        }
      },

      child: Column(
        children: [
          controller.status == AnimationStatus.forward
              ? Text('Hold it for $animationDuration seconds')
              : Text(''),
          Center(
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                border: Border.all(
                  color: Theme.of(context).accentColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('New Token '),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: controller.value,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).accentColor),
                      ),
                      Icon(Icons.autorenew),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  SettingsWidget({Key key}) : super(key: key);

  Widget tokenSection(token, Color color, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Token',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              IconButton(
                icon: Icon(Icons.share, color: borderColor),
                onPressed: () {
                  Share.share('Navand Token is \n(' + token + ')');
                },
              ),
            ],
          ),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Container(
              child: SelectableText(
                token,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 26),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    Color borderColor = Theme.of(context).accentColor;

    return Consumer<AppState>(
      builder: (BuildContext context, AppState state, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                tokenSection(state.token, color, borderColor),
                RenewButton(),
                Divider(),
                TestMessageWidget()
              ],
            ),
          ),
        );
      },
    );
  }
}
