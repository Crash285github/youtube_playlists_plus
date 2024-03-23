import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/enum_title_case.dart';
import 'package:ytp_new/extensions/offset_context_menu.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/drawer/settings/template.dart';

class SettingsSchemeMode extends StatelessWidget {
  const SettingsSchemeMode({super.key});

  Future _set(BuildContext context, Offset offset) async {
    final scheme = await offset.showContextMenu<ColorSchemeSetting>(
      context: context,
      items: [
        ...ColorSchemeSetting.values.map((e) => PopupMenuItem(
              value: e,
              child: Text(e.titleCase),
            ))
      ],
    );

    if (scheme != null) {
      SettingsProvider().colorScheme = scheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.select<SettingsProvider, String>(
      (final settings) => settings.colorScheme.titleCase,
    );

    return SettingTemplate(
      onTapUp: (details) => _set(context, details.globalPosition),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.color_lens_outlined),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("Color Scheme"),
              ),
            ],
          ),
          Text(scheme),
        ],
      ),
    );
  }
}
