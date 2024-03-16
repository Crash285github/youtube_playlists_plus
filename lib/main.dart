import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/model/settings/theme_creator.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/refreshing_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/responsive/responsive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Persistence.init();
  Persistence.loadSettings();
  Persistence.loadPlaylists();

  await ThemeCreator.createColorScheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlaylistStorageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RefreshingProvider(),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
