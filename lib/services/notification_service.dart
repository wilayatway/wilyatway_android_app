import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 🔔 Android Notification Channel
  static const AndroidNotificationDetails _androidDetails =
      AndroidNotificationDetails(
        'wilayat_channel',
        'Wilayat Notifications',
        channelDescription:
            'Daily spiritual reminders for Zikr, Tahajjud and Salah',
        importance: Importance.max,
        priority: Priority.high,
      );

  static const NotificationDetails _platformDetails = NotificationDetails(
    android: _androidDetails,
  );

  /// 🔥 Background Notification Tap Handler
  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse response) {
    debugPrint("Background notification tapped: ${response.payload}");
  }

  /// 🚀 Initialize Notifications (LATEST VERSION SAFE)
  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("Foreground notification tapped: ${response.payload}");
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // 🌍 Timezone Setup
    tz.initializeTimeZones();

    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();

    final fixedTimeZone =
        (timeZoneName == 'Asia/Calcutta') ? 'Asia/Kolkata' : timeZoneName;

    tz.setLocalLocation(tz.getLocation(fixedTimeZone));

    // 🔐 Request permissions after initialization
    await requestNotificationPermission();
  }

  /// 🔐 Request Permissions (Android 13+, iOS, Battery)
  static Future<void> requestNotificationPermission() async {
    // Android 13+
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // iOS permission request
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // 🔋 Battery Optimization (Android)
    if (await Permission.ignoreBatteryOptimizations.isDenied) {
      await Permission.ignoreBatteryOptimizations.request();
    }
  }

  /// 🔔 Show Instant Notification
  static Future<void> showInstantNotification(
    String title,
    String body, {
    String? payload,
  }) async {
    await _notificationsPlugin.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: _platformDetails,
      payload: payload,
    );
  }

  /// 📅 Schedule Daily Notification
  static Future<void> scheduleDailyNotification(
    int id,
    String title,
    String body,
    int hour,
    int minute, {
    String? payload,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id: id,
      scheduledDate: _nextInstanceOfTime(hour, minute),
      notificationDetails: _platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      title: title,
      body: body,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// ⏰ Get Next Scheduled Instance
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  /// 🔁 Schedule All Wilayat Way Daily Reminders
  static Future<void> scheduleAllNotifications() async {
    // 🚫 Prevent duplicates
    await _notificationsPlugin.cancelAll();

    await scheduleDailyNotification(
      1,
      '🌙 Tahajjud Time',
      '⏰ Wake up for Tahajjud!\n💖 Engage in Zikr and Salah.',
      2,
      30,
      payload: 'tahajjud',
    );

    await scheduleDailyNotification(
      2,
      '🌙 Tahajjud Reminder',
      '🕒 Time for quiet reflection.\n📿 Don’t miss Zikr.',
      3,
      0,
      payload: 'tahajjud',
    );

    await scheduleDailyNotification(
      3,
      '✨ Late Night Zikr',
      '📿 Continue your Zikr journey.\n🌌 Connect with Allah.',
      3,
      30,
      payload: 'zikr',
    );

    await scheduleDailyNotification(
      4,
      '🌄 Fajr Prep',
      '💧 Make Wudu & do Zikr before Fajr.',
      4,
      0,
      payload: 'fajr',
    );

    await scheduleDailyNotification(
      5,
      '🌞 Morning Zikr',
      '🌼 Start your day with Zikr!\n💖 Apne din ko Allah ke Zikr se shuru karein.',
      7,
      0,
      payload: 'morning_zikr',
    );

    await scheduleDailyNotification(
      6,
      '🌞 Morning Boost',
      '📿 Apna Zikr jari rakhein 💬',
      8,
      0,
      payload: 'morning_boost',
    );

    await scheduleDailyNotification(
      7,
      '🔔 Daily Reminder',
      '🕙 Keep Allah in your heart 💖\nZikr jari rakhein.',
      10,
      0,
      payload: 'daily',
    );

    await scheduleDailyNotification(
      8,
      '🕛 Midday Zikr',
      '🌞 Zikr continues...\n🧘‍♂️ Allah ko yaad karein.',
      12,
      0,
      payload: 'midday',
    );

    await scheduleDailyNotification(
      9,
      '🕑 Afternoon Check-in',
      '📿 Zikr se dil ko sukoon milega 💚',
      14,
      0,
      payload: 'afternoon',
    );

    await scheduleDailyNotification(
      10,
      '🕓 Asr Reminder',
      '🕌 Zikr na bhoolen, Allah ki yaad me raho 💫',
      16,
      0,
      payload: 'asr',
    );

    await scheduleDailyNotification(
      11,
      '🌇 Evening Zikr',
      '🕌 Maghrib ke baad ka Zikr 💫\nAllah ke zikr mein waqt guzariyein.',
      18,
      30,
      payload: 'evening',
    );

    await scheduleDailyNotification(
      12,
      '🌙 Night Zikr',
      '😴 Before you sleep\n📿 Zikr karke soyen.\nProtect your heart 💖',
      22,
      30,
      payload: 'night',
    );
  }

  /// ❌ Cancel All Notifications
  static Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }
}
