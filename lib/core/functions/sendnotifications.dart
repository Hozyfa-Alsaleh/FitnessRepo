import 'dart:convert';

import 'package:http/http.dart' as http;

sendNotification(String topic, String title, String content) async {
  var headersList = {
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAA5JVK_2c:APA91bE4BaDGuNH8bBl086IJv_awyjfGdWSUdCeZr0OC4XCjaduzsmIfAcVBDeCGlgmo1mehCbYyeldYFmR93nm7f8IaEDs0xE9XQYVjfIGkHsgrWXg0hSp_oX4DW5MlkdUkhRlyD5jk'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to": '/topics/$topic',
    "notification": {"title": title, "body": content}
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    print(resBody);
  } else {
    print(res.reasonPhrase);
  }
}
