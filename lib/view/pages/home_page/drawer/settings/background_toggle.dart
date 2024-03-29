import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/notification_service.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/template.dart';

class BackgroundToggle extends StatelessWidget {
  const BackgroundToggle({super.key});

  bool get _enabled => Settings.runInBackground;

  void _toggle() {
    NotificationsService.show(
      title: "title",
      body: "body",
      id: 1,
      payload: "payload",
    );
    SettingsProvider().runInBackground = !Settings.runInBackground;
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
