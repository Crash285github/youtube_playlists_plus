import 'package:flutter/material.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';

class SettingsSplitMode extends StatelessWidget {
  const SettingsSplitMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (Settings.splitMode == SplitSetting.disabled) {
            SettingsProvider().splitMode = SplitSetting.even;
          } else {
            SettingsProvider().splitMode = SplitSetting.disabled;
          }
        },
        child: const Text('split'),
      ),
    );
  }
}
