import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<bool?> init() async => await _plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );

  static Future<NotificationDetails> _notificationDetails({
    required String title,
    required String body,
    required int id,
  }) async =>
      NotificationDetails(
        android: AndroidNotificationDetails(
          '$id',
          title,
          channelDescription: body,
          importance: Importance.max,
        ),
      );

  @pragma('vm:entry-point')
  static Future<void> show({
    int id = 0,
    required String title,
    required String body,
    String? payload,
  }) async =>
      _plugin.show(
        id,
        title,
        body,
        await _notificationDetails(title: title, body: body, id: id),
        payload: payload,
      );
}
