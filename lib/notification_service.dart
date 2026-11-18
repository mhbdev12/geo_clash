import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      tz.initializeTimeZones();

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Request notification permission for Android 13+
      await requestPermission();

      _isInitialized = true;
    } catch (e) {
      debugPrint("Error initializing NotificationService: $e");
    }
  }

  /// Request runtime notification permissions on Android 13+ (API 33+)
  Future<void> requestPermission() async {
    try {
      final androidPlugin = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
      }
    } catch (e) {
      debugPrint("Error requesting notification permission: $e");
    }
  }

  /// Resets and schedules inactivity reminders for 1 day (24h) and 2 days (48h) in the future
  Future<void> scheduleInactivityReminders() async {
    await init();
    try {
      // Cancel previous inactivity reminder timers
      await flutterLocalNotificationsPlugin.cancel(101);
      await flutterLocalNotificationsPlugin.cancel(102);

      // 1-Day Reminder (24 Hours after last active session)
      await scheduleGeoClashReminder(
        id: 101,
        title: "🌍 Geo Clash Challenge Waiting!",
        body: "Test your flag & capital knowledge! Can you set a new high score today? 🎯",
        hoursFromNow: 24,
      );

      // 2-Day Reminder (48 Hours after last active session)
      await scheduleGeoClashReminder(
        id: 102,
        title: "🏆 Don't lose your streak!",
        body: "Your geography skills miss you! Jump back in and master new maps now! 🗺️",
        hoursFromNow: 48,
      );
    } catch (e) {
      debugPrint("Error scheduling inactivity reminders: $e");
    }
  }

  Future<void> scheduleGeoClashReminder({
    required int id,
    required String title,
    required String body,
    required int hoursFromNow,
  }) async {
    final scheduledDate = tz.TZDateTime.now(tz.local).add(Duration(hours: hoursFromNow));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'geo_clash_channel',
          'Geo Clash Reminders',
          channelDescription: 'Reminds you to test your geography knowledge',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
