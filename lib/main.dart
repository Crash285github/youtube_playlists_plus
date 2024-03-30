import 'dart:io';

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
import 'package:ytp_new/service/sharing_service.dart';
import 'package:ytp_new/view/responsive/responsive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  if (Platform.isAndroid) {
    try {
      await BackgroundService.configure();
      BackgroundService.registerHeadlessTask();
    } catch (_) {}
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

    if (Platform.isAndroid) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => SharingService.receive());
    }
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
