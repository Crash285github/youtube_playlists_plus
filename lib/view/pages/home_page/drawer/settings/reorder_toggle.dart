import 'package:flutter/material.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/template.dart';

class SettingsReorderToggle extends StatelessWidget {
  const SettingsReorderToggle({super.key});

  void _toggle(context) {
    SettingsProvider().canReorder = !SettingsProvider().canReorder;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => SettingTemplate(
        onTap: () => _toggle(context),
        child: const Row(
          children: [
            Icon(Icons.sort),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text("Reorder Playlists"),
            )
          ],
        ),
      );
}
