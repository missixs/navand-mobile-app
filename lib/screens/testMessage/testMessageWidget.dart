import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:navand/models/appState.dart';

class TestMessageWidget extends StatefulWidget {
  TestMessageWidget({Key key}) : super(key: key);

  @override
  _TestMessageWidgetState createState() => _TestMessageWidgetState();
}

class _TestMessageWidgetState extends State<TestMessageWidget> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Consumer<AppState>(
        builder: (BuildContext context, AppState state, Widget child) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Test Message',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                        Text(
                          'Send a test message to your browser to ensure everything works correctly',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      controller: myController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Enter your message',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        print(state.token);
                        state.onSendTestMessage(
                            context, 'Test Message', myController.text);
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
