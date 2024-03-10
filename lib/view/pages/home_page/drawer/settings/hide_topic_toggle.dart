import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/template.dart';

class SettingsHideTopicToggle extends StatelessWidget {
  const SettingsHideTopicToggle({super.key});

  bool get _enabled => Settings.hideTopic;

  void _toggle() => SettingsProvider().hideTopic = !Settings.hideTopic;

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context);
    return SettingTemplate(
      onTap: _toggle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.note_outlined),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("Hide '- Topic'"),
              )
            ],
          ),
          Switch(
            value: _enabled,
            onChanged: (_) => _toggle(),
          )
        ],
      ),
    );
  }
}
