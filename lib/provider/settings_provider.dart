import 'package:flutter/material.dart';
import 'package:ytp_new/model/settings/app_theme_mode.dart';
import 'package:ytp_new/model/settings/settings.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeData get theme =>
      themeMode == AppThemeMode.dark ? ThemeData.dark() : ThemeData.light();
  AppThemeMode get themeMode => Settings.themeMode;
  set themeMode(final AppThemeMode themeMode) {
    Settings.themeMode = themeMode;
    notifyListeners();
  }

  //_ Singleton
  static final _provider = SettingsProvider._();
  factory SettingsProvider() => _provider;
  SettingsProvider._();
}
