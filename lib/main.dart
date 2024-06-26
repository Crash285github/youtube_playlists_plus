import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
import 'package:ytp_new/view/widget/responsive/responsive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Persistence.init();
  Persistence.loadPreferences();
  Persistence.loadPlaylists();
  Persistence.loadAnchors();

  await ThemeCreator.createColorScheme();

  await _setupApp();

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
}

/// Setup the Windows app minimum and default window sizes
Future<void> _setupWindowsApp() async {
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

/// Sets up Android specific features
Future<void> _setupAndroidApp() async {
  try {
    //? Setup background work
    await BackgroundService.configure();
    await BackgroundService.registerHeadlessTask();

    if (!Preferences.runInBackground) {
      BackgroundService.stop();
    } else {
      BackgroundService.start();
    }
  } catch (_) {}

  //? Setup sharing intents
  WidgetsBinding.instance.addPostFrameCallback((_) => SharingService.receive());

  //? change status bar color to transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

/// Sets [AppConfig.appVersion] and calls
/// a platform-specific setup function
Future<void> _setupApp() async {
  final info = await PackageInfo.fromPlatform();
  AppConfig.appVersion = info.version;

  if (Platform.isAndroid) return await _setupAndroidApp();
  if (Platform.isWindows) return await _setupWindowsApp();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
