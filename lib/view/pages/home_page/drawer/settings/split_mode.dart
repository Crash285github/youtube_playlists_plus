import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/enum_title_case.dart';
import 'package:ytp_new/extensions/offset_context_menu.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/template.dart';

class SettingsSplitMode extends StatelessWidget {
  const SettingsSplitMode({super.key});

  Future _set(BuildContext context, Offset offset) async {
    final mode = await offset.showContextMenu<SplitSetting>(
      context: context,
      items: [
        ...SplitSetting.values.map(
          (e) => PopupMenuItem(
            value: e,
            child: Text(e.titleCase),
          ),
        ),
      ],
    );

    if (mode != null) {
      SettingsProvider().splitMode = mode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode = context.select<SettingsProvider, String>(
      (final settings) => settings.splitMode.titleCase,
    );

    return SettingTemplate(
      onTapUp: (details) => _set(context, details.globalPosition),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              RotatedBox(quarterTurns: 1, child: Icon(Icons.splitscreen)),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Split view'),
              ),
            ],
          ),
          Text(mode)
        ],
      ),
    );
  }
}
