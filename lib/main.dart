import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:navand/screens/welcome/welcomeWidget.dart';
import 'package:navand/screens/settings/settings.dart';
import 'package:navand/screens/drawer/Drawer.dart';
import 'package:navand/models/appState.dart';

import 'package:flutter/services.dart';
import 'package:navand/utils/formUtils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(context),
      child: MaterialApp(
        title: 'Navand',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            canvasColor: Colors.white),
        home: MyHomePage(
          title: 'Navand',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const EventChannel callChannel =
      EventChannel('com.missixs.navand/call');
  @override
  void initState() {
    super.initState();
    // eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    // timeChannel.receiveBroadcastStream().listen(_onTimeEvent, onError: _onTimeError);
    String token;
    token = Provider.of<AppState>(context, listen: false).token;

    print('Call2342 00 $token');

    callChannel.receiveBroadcastStream().listen((Object event) {
      Provider.of<AppState>(context, listen: false).onCallReceive();
      print('Call 0 received Baby $event ');
    }, onError: _onCallError);
    // callChannel.receiveBroadcastStream().listen(_onCallReceive, onError: _onCallError);
    // callChannel.receiveBroadcastStream().
  }

  void _onCallError(Object event) {
    print('Call Event error is Dispatched!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WelcomeWidget(),
      drawer: Drawer(
        child: AppDrawer(),
      ),
    );
  }
}
