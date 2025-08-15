import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionActions, PermissionStatusGetters;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _notificationsPlugin.initialize(settings);
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    // Fix common outdated timezones
    final fixedTimeZone =
        (timeZoneName == 'Asia/Calcutta') ? 'Asia/Kolkata' : timeZoneName;

    tz.setLocalLocation(tz.getLocation(fixedTimeZone));
  }

  static Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  static Future<void> showInstantNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'wilayat_channel',
      'Wilayat Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(0, title, body, platformDetails);
  }

  static Future<void> scheduleDailyNotification(
    int id,
    String title,
    String body,
    int hour,
    int minute,
  ) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'wilayat_channel',
          'Wilayat Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

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

  static Future<void> scheduleAllNotifications() async {
    await scheduleDailyNotification(
      1,
      '🌙 Tahajjud Time',
      '⏰ Wake up for Tahajjud!\n💖 Engage in Zikr and Salah.',
      2,
      30,
    );
    await scheduleDailyNotification(
      2,
      '🌙 Tahajjud Reminder',
      '🕒 time for quiet reflection.\n📿 Don’t miss Zikr.',
      3,
      00,
    );
    await scheduleDailyNotification(
      3,
      '✨ Late Night Zikr',
      '📿 Continue your Zikr journey.\n🌌 Connect with Allah.',
      3,
      30,
    );
    await scheduleDailyNotification(
      4,
      '🌄 Fajr Prep',
      '💧 Make Wudu & do Zikr before Fajr.\n🌅',
      4,
      00,
    );
    await scheduleDailyNotification(
      5,
      '🌞 Morning Zikr',
      '🕖 🌼 Start your day with Zikr!\n💖 Apne din ko Allah ke Zikr se shuru karein.',
      7,
      0,
    );
    await scheduleDailyNotification(
      6,
      '🌞 Morning Boost',
      '📿  Apna Zikr jari rakhein 💬',
      8,
      0,
    );
    await scheduleDailyNotification(
      7,
      '🔔 Daily Reminder',
      '🕙 Keep Allah in your heart 💖\nZikr jari rakhein.',
      10,
      0,
    );
    await scheduleDailyNotification(
      8,
      '🕛 Midday Zikr',
      '🌞 Zikr continues... 🧘‍♂️ Apne routine ke saath Allah ko yaad karein.',
      12,
      0,
    );
    await scheduleDailyNotification(
      9,
      '🕑 Afternoon Check-in',
      '📿  Zikr se dil ko sukoon milega 💚',
      14,
      0,
    );
    await scheduleDailyNotification(
      10,
      '🕓 Asr Reminder',
      '🕌 Zikr na bhoolen, Allah ki yaad me raho 💫',
      16,
      0,
    );
    await scheduleDailyNotification(
      11,
      '🌇 Evening Zikr',
      '🕌 Maghrib ke baad ka Zikr 💫\nApna waqt Allah ke zikr mein guzariyein.',
      18,
      30,
    );
    await scheduleDailyNotification(
      12,
      '🌙 Night Zikr',
      '😴 Before you sleep 💤\n📿 Zikr karke soyen.\nProtect your heart with remembrance 💖',
      22,
      30,
    );
  }
}
