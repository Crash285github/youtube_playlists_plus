import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/home_page.dart';
import 'package:ytp_new/view/responsive/empty_right.dart';

/// A left & right navigator layout
class SplitView extends StatelessWidget {
  const SplitView({super.key});

  @override
  Widget build(BuildContext context) {
    final isEven = context.select<SettingsProvider, bool>(
      (final settings) => settings.splitMode == SplitSetting.even,
    );

    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          flex: isEven ? 1 : 5,
          child: Navigator(
            key: AppConfig.splitRightNavigatorKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const EmptyRightSide(),
            ),
          ),
        ),
        Expanded(
            flex: isEven ? 1 : 3,
            child: Navigator(
              key: AppConfig.splitLeftNavigatorKey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ))
      ],
    );
  }
}
