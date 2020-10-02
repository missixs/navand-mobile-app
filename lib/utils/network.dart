import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:navand/config.dart';

class NetworkManager {
  final String instanceId = pusherInstanceId;
  final String authorization = pusherAuthorization;

  Future<void> sendNotification(String token, String title, String body) async {
    String url =
        'https://$instanceId.pushnotifications.pusher.com/publish_api/v1/instances/$instanceId/publishes';
    print("Sending Notification");
    var response = await http.post(
      '$url',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': '$authorization',
      },
      body: jsonEncode(<String, dynamic>{
        "interests": ['$token'],
        "web": {
          "notification": {
            "title": "$title",
            "body": "$body",
          },
        },
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //Scaffold.of(context).showSnackBar(snackBar);
  }
}
