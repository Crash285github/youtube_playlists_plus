import 'package:flutter/material.dart';
import 'package:ytp_new/config.dart';

class AppNavigator {
  static Future<T?> pushMain<T extends Object>(final Widget screen) async =>
      Navigator.push<T>(
          AppConfig.mainNavigatorKey.currentContext!,
          MaterialPageRoute<T>(
            builder: (context) => screen,
          ));

  static Future<T?> tryPushRight<T extends Object>(final Widget screen) async =>
      Navigator.push<T>(
          AppConfig.splitRightNavigatorKey.currentContext ??
              AppConfig.mainNavigatorKey.currentContext!,
          MaterialPageRoute<T>(
            builder: (context) => screen,
          ));

  static void tryPopRight<T extends Object>([T? result]) {
    final nav = Navigator.of(AppConfig.splitRightNavigatorKey.currentContext ??
        AppConfig.mainNavigatorKey.currentContext!);

    if (nav.canPop()) {
      nav.pop<T>(result);
    }
  }

  static Future<T?> tryPushLeft<T extends Object>(final Widget screen) async =>
      Navigator.push<T>(
          AppConfig.splitLeftNavigatorKey.currentContext ??
              AppConfig.mainNavigatorKey.currentContext!,
          MaterialPageRoute<T>(
            builder: (context) => screen,
          ));
}
