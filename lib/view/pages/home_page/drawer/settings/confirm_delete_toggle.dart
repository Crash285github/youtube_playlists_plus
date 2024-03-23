import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/template.dart';

class SettingsConfirmDeleteToggle extends StatelessWidget {
  const SettingsConfirmDeleteToggle({super.key});

  bool get _enabled => Settings.confirmDeletes;

  void _toggle() =>
      SettingsProvider().confirmDeletes = !Settings.confirmDeletes;

  @override
  Widget build(BuildContext context) {
    context.select<SettingsProvider, bool>(
      (final settings) => settings.confirmDeletes,
    );

    return SettingTemplate(
      onTap: _toggle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.delete_outline),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("Confirm deletions"),
              )
            ],
          ),
          Switch(
            value: _enabled,
            onChanged: (_) => _toggle(),
          ),
        ],
      ),
    );
  }
}
