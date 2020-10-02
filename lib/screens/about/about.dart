import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navand/config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/typicons_icons.dart';


class AboutUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String assetName = 'images/navand.svg';
    final Widget svgIcon = SvgPicture.asset(assetName,
        color: Colors.white, semanticsLabel: 'Navand Icon');
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 1.0,
          heightFactor: orientation == Orientation.landscape? 0.95:0.5,
          child: Center(
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 80,
                  child: svgIcon,
                ),
                Container(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(
                    child: Text(
                      'Version $version',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    textScaleFactor: 1.5,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: "Developed with ",
                        ),
                        WidgetSpan(
                            child: Icon(
                              Typicons.heart_filled,
                              color: Colors.red,
                            ),
                            alignment: PlaceholderAlignment.middle),
                        TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: "by missixs",
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'missixs@protonmail.com',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
