part of responsive;

/// A left & right navigator layout
class _SplitView extends StatelessWidget {
  const _SplitView();

  @override
  Widget build(BuildContext context) {
    final isEven = context.select<SettingsProvider, bool>(
      (final settings) => settings.splitMode == SplitSetting.even,
    );

    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          flex: isEven ? 1 : 5,
          child: Navigator(
            key: AppConfig.splitRightNavigatorKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const _EmptyRightSide(),
            ),
          ),
        ),
        Expanded(
            flex: isEven ? 1 : 3,
            child: Navigator(
              key: AppConfig.splitLeftNavigatorKey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ))
      ],
    );
  }
}
