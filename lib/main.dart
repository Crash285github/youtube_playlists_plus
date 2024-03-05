import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/pages/home_page/home_page.dart';
import 'package:ytp_new/view/pages/search_page/search_page.dart';
import 'package:ytp_new/view/responsive/responsive.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => PlaylistStorageProvider(),
    )
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
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
