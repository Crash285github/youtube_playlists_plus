import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/home_page.dart';
import 'package:ytp_new/view/responsive/split_view.dart';

/// Handles splitting the app on big screens
class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Provider.of<SettingsProvider>(context).splitMode;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700 && mode != SplitSetting.disabled) {
          return const SplitView();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
