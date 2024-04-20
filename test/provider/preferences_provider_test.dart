import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/provider/preferences_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await Persistence.init();
  group('PreferencesProvider', () {
    test("theme changes", () {
      for (final theme in ThemePreference.values) {
        PreferencesProvider().theme = theme;
        expect(Preferences.theme, theme);
        expect(PreferencesProvider().theme, theme);
      }
    });

    test("colorScheme changes", () {
      for (final scheme in ColorSchemePreference.values) {
        PreferencesProvider().colorScheme = scheme;
        expect(Preferences.colorScheme, scheme);
        expect(PreferencesProvider().colorScheme, scheme);
      }
    });

    test("splitMode changes", () {
      for (final mode in SplitPreference.values) {
        PreferencesProvider().splitMode = mode;
        expect(Preferences.splitMode, mode);
        expect(PreferencesProvider().splitMode, mode);
      }
    });

    test("hideTopic changes", () {
      PreferencesProvider().hideTopic = false;
      expect(Preferences.hideTopic, false);
      expect(PreferencesProvider().hideTopic, false);

      PreferencesProvider().hideTopic = true;
      expect(Preferences.hideTopic, true);
      expect(PreferencesProvider().hideTopic, true);
    });

    test("canReorder changes", () {
      PreferencesProvider().canReorder = false;
      expect(Preferences.canReorder, false);
      expect(PreferencesProvider().canReorder, false);

      PreferencesProvider().canReorder = true;
      expect(Preferences.canReorder, true);
      expect(PreferencesProvider().canReorder, true);
    });

    test("confirmDeletes changes", () {
      PreferencesProvider().confirmDeletes = false;
      expect(Preferences.confirmDeletes, false);
      expect(PreferencesProvider().confirmDeletes, false);

      PreferencesProvider().confirmDeletes = true;
      expect(Preferences.confirmDeletes, true);
      expect(PreferencesProvider().confirmDeletes, true);
    });

    test("runInBackground changes", () {
      PreferencesProvider().runInBackground = false;
      expect(Preferences.runInBackground, false);
      expect(PreferencesProvider().runInBackground, false);

      PreferencesProvider().runInBackground = true;
      expect(Preferences.runInBackground, true);
      expect(PreferencesProvider().runInBackground, true);
    });
  });
}
