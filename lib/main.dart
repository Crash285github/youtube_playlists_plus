import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/local_storage.dart';
import 'package:ytp_new/model/settings/theme_creator.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/refreshing_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/responsive/responsive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //debug (await SharedPreferences.getInstance()).clear();

  await LocalStorage.init();
  LocalStorage.loadSettings();
  LocalStorage.loadPlaylists();
  await ThemeCreator.create();

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
    Provider.of<SettingsProvider>(context);

    return MaterialApp(
      theme: ThemeCreator.theme,
      navigatorKey: AppConfig.mainNavigatorKey,
      scrollBehavior:
          const MaterialScrollBehavior().copyWith(scrollbars: false),
      home: Scaffold(
        body: DynamicColorBuilder(
            builder: (lightDynamic, darkDynamic) => const Responsive()),
      ),
    );
  }
}
