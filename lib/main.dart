import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/model/theme_creator.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/background_service.dart';
import 'package:ytp_new/service/notification_service.dart';
import 'package:ytp_new/service/sharing_service.dart';
import 'package:ytp_new/view/responsive/responsive.dart';

@pragma('vm:entry-point')

/// This "Headless Task" is run when app is terminated.
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  var taskId = task.taskId;
  var timeout = task.timeout;
  if (timeout) {
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print("[BackgroundFetch] Headless event received: $taskId");

  await NotificationsService.init();
  NotificationsService.show(title: 'test', body: "fact");

  BackgroundService.finish(taskId);
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationsService.init();

  await Persistence.init();

  Persistence.loadSettings();
  Persistence.loadPlaylists();
  Persistence.loadAnchors();

  await ThemeCreator.createColorScheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlaylistStorageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AnchorStorageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FetchingProvider(),
        )
      ],
      child: const MainApp(),
    ),
  );

  BackgroundService.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      initBg();
      WidgetsBinding.instance
          .addPostFrameCallback((_) => SharingService.receive());
    }
  }

  void initBg() async {
    try {
      var status = await BackgroundService.configure(
          _onBackgroundFetch, _onBackgroundFetchTimeout);

      print('[BackgroundFetch] configure success: $status');

      if (!Settings.runInBackground) {
        print("Stopping bg service");
        BackgroundService.stop();
      }
    } catch (e) {
      print("[BackgroundFetch] configure ERROR: $e");
    }
  }

  void _onBackgroundFetch(String taskId) async {
    // This is the fetch-event callback.
    print("[BackgroundFetch] Event received: $taskId");

    // Persist fetch events in SharedPreferences

    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundService.finish(taskId);
  }

  /// This event fires shortly before your task is about to timeout.  You must finish any outstanding work and call BackgroundFetch.finish(taskId).
  void _onBackgroundFetchTimeout(String taskId) {
    print("[BackgroundFetch] TIMEOUT: $taskId");
    BackgroundService.finish(taskId);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SettingsProvider>();

    return MaterialApp(
      theme: ThemeCreator.theme,
      navigatorKey: AppConfig.mainNavigatorKey,
      home: PopScope(
        canPop: !SettingsProvider().canReorder,
        onPopInvoked: (didPop) {
          if (!didPop) {
            SettingsProvider().canReorder = false;
          }
        },
        child: const Scaffold(body: Responsive()),
      ),
    );
  }
}
