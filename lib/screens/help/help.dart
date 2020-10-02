import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:navand/screens/help/helpText.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Html(
            data: helpText,
          ),
        ),
      ),
    );
  }
}
