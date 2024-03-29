import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/background_service.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/template.dart';

class BackgroundToggle extends StatelessWidget {
  const BackgroundToggle({super.key});

  bool get _enabled => Settings.runInBackground;

  void _toggle() {
    SettingsProvider().runInBackground = !Settings.runInBackground;

    if (!Platform.isAndroid) return;
    if (_enabled) {
      print("enabled bg");
      BackgroundService.start();
      FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();

      BackgroundFetch.scheduleTask(
        TaskConfig(
          taskId: "com.transistorsoft.customtask",
          delay: 10000,
          periodic: false,
          forceAlarmManager: false,
          stopOnTerminate: false,
          enableHeadless: true,
        ),
      );
    } else {
      print("disabled bg");
      BackgroundService.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.select<SettingsProvider, bool>(
      (final settings) => settings.runInBackground,
    );

    return SettingTemplate(
      onTap: _toggle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.notifications_active_outlined),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("Run in background"),
              )
            ],
          ),
          Switch(
            value: _enabled,
            onChanged: (_) => _toggle(),
          ),
        ],
      ),
    );
  }
}
