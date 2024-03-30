import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void onTap(NotificationResponse response) {}

  static Future init() async {
    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static Future _notificationDetails(
          final String title, final String body, final int id) async =>
      NotificationDetails(
        android: AndroidNotificationDetails(
          '$id',
          title,
          channelDescription: body,
          importance: Importance.max,
          styleInformation: const BigTextStyleInformation(''),
        ),
      );

  @pragma('vm:entry-point')
  static Future show({
    int id = 0,
    required String title,
    required String body,
    String? payload,
  }) async =>
      _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        await _notificationDetails(title, body, id),
        payload: payload,
      );
}
