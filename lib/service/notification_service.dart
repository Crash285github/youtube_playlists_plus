import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<bool?> init() async => await _plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
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
        payload: payload,
        NotificationDetails(
          android: AndroidNotificationDetails(
            '$id',
            title,
            channelDescription: body,
            importance: Importance.max,
          ),
        ),
      );
}
