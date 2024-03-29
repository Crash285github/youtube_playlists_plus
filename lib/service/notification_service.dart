import 'dart:math';

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

  static Future _notificationDetails() async => NotificationDetails(
        android: AndroidNotificationDetails(
            'ytp+${Random(DateTime.now().millisecondsSinceEpoch).nextInt(10)}',
            'ytp+ name',
            channelDescription: 'ytp+ desc',
            importance: Importance.max,
            styleInformation: const BigTextStyleInformation('')),
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
        await _notificationDetails(),
        payload: payload,
      );
}
