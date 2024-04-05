library responsive;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/provider/preferences_provider.dart';
import 'package:ytp_new/view/pages/home_page/home_page.dart';

part 'empty_right.dart';
part 'split_view.dart';

/// Handles splitting the app on big screens
class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.select<PreferencesProvider, SplitPreference>(
      (final preferences) => preferences.splitMode,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700 && mode != SplitPreference.disabled) {
          Preferences.isSplit = true;
          return const _SplitView();
        } else {
          Preferences.isSplit = false;
          return const HomePage();
        }
      },
    );
  }
}
