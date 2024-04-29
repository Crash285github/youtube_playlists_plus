import 'package:background_fetch/background_fetch.dart';
import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/service/notification_service.dart';

class BackgroundService {
  /// Configures the [BackgroundService]
  static Future<int> configure() => BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval:
              const String.fromEnvironment("FLUTTER_APP_FLAVOR").endsWith("dev")
                  ? 15
                  : 1440,
          forceAlarmManager: false,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.ANY,
        ),
        () {},
        () async {
          if (const String.fromEnvironment("FLUTTER_APP_FLAVOR")
              .endsWith('dev')) {
            await NotificationsService.init();
            NotificationsService.show(
              id: 4,
              title: 'Fetch timed out.',
              body: "...",
            );
          }
        },
      );

  /// Registers the `headless` task that runs in the background
  static Future<bool> registerHeadlessTask() =>
      BackgroundFetch.registerHeadlessTask(
          BackgroundService._backgroundRefresh);

  /// Finishes a given task
  static void _finish(final String taskId) => BackgroundFetch.finish(taskId);

  /// Starts the [BackgroundService]
  static Future<int> start() => BackgroundFetch.start();

  /// Stops the [BackgroundService]
  static Future<int> stop() => BackgroundFetch.stop();

  /// Refreshes all [Playlist]s as a background task
  @pragma('vm:entry-point')
  static Future<void> _backgroundRefresh(HeadlessTask task) async {
    if (task.timeout) {
      _finish(task.taskId);
      return;
    }

    await Persistence.init();
    Persistence.loadPlaylists();

    await Future.wait([
      ...PlaylistStorage.playlists.map(
        (final pl) => pl.refresh(),
      ),
    ]);

    final changed =
        PlaylistStorage.playlists.where((final pl) => pl.hasChanges);

    await NotificationsService.init();

    if (changed.length > 1) {
      NotificationsService.show(
        id: 2,
        title: 'Playlists changed!',
        body: "Multiple of your Playlists have changed. "
            "Confirm them in the app.",
      );
    } else if (changed.length == 1) {
      NotificationsService.show(
        id: 1,
        title: 'Playlist changed!',
        body: "'${changed.first.title}' has changed. " "Confirm it in the app.",
      );
    } else if (const String.fromEnvironment("FLUTTER_APP_FLAVOR")
        .endsWith("dev")) {
      NotificationsService.show(
        id: 0,
        title: 'No changes found.',
        body: "Yay!",
      );
    }

    _finish(task.taskId);
  }
}
