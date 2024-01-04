import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            icon: '@mipmap/myicon',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(id, title, body, await notificationDetails(),
          payload: payload);
}
