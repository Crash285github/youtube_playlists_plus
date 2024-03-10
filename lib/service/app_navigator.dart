import 'package:flutter/material.dart';
import 'package:ytp_new/config.dart';

/// The Application's page navigator
class AppNavigator {
  /// Push a Page to the main Navigator, obscuring both sides in case
  /// of split screen mode
  static Future<T?> pushMain<T extends Object>(final Widget page) async =>
      Navigator.push<T>(
          AppConfig.mainNavigatorKey.currentContext!,
          MaterialPageRoute<T>(
            builder: (context) => page,
          ));

  /// Push a Page to the right in split screen mode, or to main if not possible
  static Future<T?> tryPushRight<T extends Object>(final Widget page) async =>
      Navigator.push<T>(
          AppConfig.splitRightNavigatorKey.currentContext ??
              AppConfig.mainNavigatorKey.currentContext!,
          MaterialPageRoute<T>(
            builder: (context) => page,
          ));

  /// Pop a Page on the right side if possible
  static void tryPopRight<T extends Object>([T? result]) {
    final nav = Navigator.of(AppConfig.splitRightNavigatorKey.currentContext ??
        AppConfig.mainNavigatorKey.currentContext!);

    if (nav.canPop()) {
      nav.pop<T>(result);
    }
  }

  /// Push a Page to the left in split screen mode, or to main if not possible
  static Future<T?> tryPushLeft<T extends Object>(final Widget page) async =>
      Navigator.push<T>(
          AppConfig.splitLeftNavigatorKey.currentContext ??
              AppConfig.mainNavigatorKey.currentContext!,
          MaterialPageRoute<T>(
            builder: (context) => page,
          ));
}
