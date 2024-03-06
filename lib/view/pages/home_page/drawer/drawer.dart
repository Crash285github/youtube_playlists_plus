import 'package:flutter/material.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/theme.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [ThemeSetting()],
      ),
    );
  }
}
