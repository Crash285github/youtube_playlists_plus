import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/search_page/search_page.dart';
import 'package:ytp_new/view/responsive/responsive.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => PlaylistStorageProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
    )
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context);

    return MaterialApp(
      theme: SettingsProvider().theme,
      home: Scaffold(
        body: const Responsive(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  )));
        }),
      ),
    );
  }
}
