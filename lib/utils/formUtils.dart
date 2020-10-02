import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

String generateToken(){
  var uid = Uuid();
  return uid.v4();
}
void pushForm(BuildContext context, Widget Function() createPage){
  Navigator.pop(context);
  Navigator.of(context)
      .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    return createPage();
  }));
}

Future<void> showErrorDialog(
    BuildContext context, String title, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}