import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navand/screens/settings/settings.dart';
import 'package:navand/screens/privacy/privacy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:navand/screens/about/about.dart';
import 'package:navand/screens/help/help.dart';
import 'package:navand/utils/formUtils.dart';

class AppDrawer extends StatelessWidget {



  ListTile listItemBuilder(
      String text, IconData icon, Color color, GestureTapCallback callback) {
    return ListTile(
      title: Text(
        text,
      ),
      leading: Icon(
        icon,
        color: color, //,
      ),
      onTap: callback,
    );
  }

  void _onSupportClick(
      BuildContext context, String toMailId, String subject) async {
    var url = 'mailto:$toMailId?subject=$subject';
    Navigator.pop(context);

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      showErrorDialog(context, 'Oops!',
          'Something went wrong.\nPlease write to missixs@protonamail.com');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColorDark;

    final String assetName = 'images/navand.svg';
    final Widget svgIcon = SvgPicture.asset(assetName,
        color: Colors.white, semanticsLabel: 'Navand Icon');

    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: svgIcon, //Text('Drawer Header'),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        listItemBuilder(
          'Help',
          Icons.help,
          color,
          () {
            pushForm(context, ()=> Help());
          },
        ),
        listItemBuilder(
          'Settings',
          Icons.settings,
          color,
          () {
            pushForm(context, ()=> SettingsWidget());
          },
        ),
        listItemBuilder(
          'Support',
          Icons.support,
          color,
          () {
            _onSupportClick(
                context, 'missixs@protonmail.com', 'Request for support');
          },
        ),
        listItemBuilder(
          'About us',
          Icons.info_outlined,
          color,
          () {
            pushForm(context, ()=> AboutUS());
          },
        ),
        listItemBuilder(
          'Privacy policy',
          Icons.privacy_tip,
          color,
          () {
            pushForm(context, ()=> PrivacyPolicy());
          },
        ),
      ],
    );
  }
}
