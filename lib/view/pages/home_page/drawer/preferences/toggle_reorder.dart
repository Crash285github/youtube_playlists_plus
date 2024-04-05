part of preferences_drawer;

class _ToggleReorder extends StatelessWidget {
  const _ToggleReorder();

  void _toggle(context) {
    PreferencesProvider().canReorder = !PreferencesProvider().canReorder;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => _SettingTemplate(
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
