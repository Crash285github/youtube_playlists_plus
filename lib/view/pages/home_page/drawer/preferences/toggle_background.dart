part of preferences_drawer;

class _ToggleBackground extends StatelessWidget {
  const _ToggleBackground();

  bool get _enabled => Preferences.runInBackground;

  void _toggle() {
    if (!Platform.isAndroid) return;

    PreferencesProvider().runInBackground = !Preferences.runInBackground;

    if (_enabled) {
      BackgroundService.start();

      FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      // BackgroundFetch.scheduleTask(
      //   TaskConfig(
      //     taskId: "test_task",
      //     delay: 10000,
      //     periodic: false,
      //     forceAlarmManager: false,
      //     stopOnTerminate: false,
      //     enableHeadless: true,
      //   ),
      // );
    } else {
      BackgroundService.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.select<PreferencesProvider, bool>(
      (final settings) => settings.runInBackground,
    );

    return _SettingTemplate(
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
