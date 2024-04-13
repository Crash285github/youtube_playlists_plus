import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/preferences_provider.dart';
import 'package:ytp_new/service/background_service.dart';
import 'package:ytp_new/service/sharing_service.dart';
import 'package:ytp_new/view/responsive/responsive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupWindowsApp();

  await Persistence.init();
  Persistence.loadPreferences();
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
          create: (_) => PreferencesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FetchingProvider(),
        )
      ],
      child: const MainApp(),
    ),
  );

  //? Setup background work on android
  if (Platform.isAndroid) {
    try {
      await BackgroundService.configure();
      BackgroundService.registerHeadlessTask();

      if (!Preferences.runInBackground) BackgroundService.stop();
    } catch (_) {}
  }
}

/// Setup the Windows app minimum and default window sizes
Future<void> _setupWindowsApp() async {
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow().whenComplete(() async {
      await Future.wait([
        windowManager.setTitle("Youtube Playlists+"),
        windowManager.setSize(const Size(1300, 800)),
        windowManager.setMinimumSize(const Size(800, 500)),
        windowManager.setAlignment(Alignment.center),
      ]);
      await windowManager.show();
    });
  }
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

    //? Setup sharing intents on android
    if (Platform.isAndroid) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => SharingService.receive());
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PreferencesProvider>();

    return MaterialApp(
      title: "Youtube Playlists+",
      theme: ThemeCreator.theme,
      navigatorKey: AppConfig.mainNavigatorKey,
      home: PopScope(
        canPop: !PreferencesProvider().canReorder,
        onPopInvoked: (didPop) {
          if (!didPop) {
            PreferencesProvider().canReorder = false;
          }
        },
        child: const Scaffold(body: Responsive()),
      ),
    );
  }
}
