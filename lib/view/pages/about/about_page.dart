import 'package:flutter/material.dart';
import 'package:ytp_new/model/theme_creator.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: ListView(
        children: [
          Text(
            "Hi there!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppNavigator.pushMain(
          Theme(
            data: ThemeCreator.theme.copyWith(
              appBarTheme: const AppBarTheme(
                surfaceTintColor: Colors.transparent,
              ),
              listTileTheme: const ListTileThemeData(
                visualDensity: VisualDensity.compact,
                dense: true,
              ),
            ),
            child: LicensePage(
              applicationName: "Youtube Playlists+",
              applicationVersion: "0.9.2",
              applicationIcon: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: const Image(
                  image: ResizeImage(
                    height: 40,
                    AssetImage("assets/app_icon.png"),
                  ),
                ),
              ),
            ),
          ),
        ),
        tooltip: "Licenses",
        child: const Icon(
          Icons.assignment,
        ),
      ),
    );
  }
}
