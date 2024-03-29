import 'package:background_fetch/background_fetch.dart';

class BackgroundService {
  static Future<bool> registerHeadlessTask(Function callback) =>
      BackgroundFetch.registerHeadlessTask(callback);

  static Future<int> configure(Function onFetch, [Function? onTimeout]) =>
      BackgroundFetch.configure(
          BackgroundFetchConfig(
            minimumFetchInterval: 15,
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
          onFetch,
          onTimeout);

  static void finish(String taskId) => BackgroundFetch.finish(taskId);

  static Future<int> start() => BackgroundFetch.start();
  static Future<int> stop() => BackgroundFetch.stop();
  static Future<int> get status => BackgroundFetch.status;
}
