import 'package:flutter/material.dart';
import 'package:wilayat_way_apk/screens/dashboard_screen.dart';
// import 'package:wilayat_way_apk/screens/pages/spiritualcontent/spiritual_content_screen.dart';
import 'package:wilayat_way_apk/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the Firebase options file
import 'package:wilayat_way_apk/screens/user_details_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await NotificationService.initialize();
    await NotificationService.scheduleAllNotifications();
    await NotificationService.requestNotificationPermission();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // FCM setup
    await _setupFCM();
  } catch (e) {
    print("Error during initialization: $e");
  }
  runApp(const WilayatWayApp());
}

Future<void> _setupFCM() async {
  // Request FCM permissions (iOS)
  await FirebaseMessaging.instance.requestPermission();

  // Get FCM token
  String? token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: ${token ?? 'null'}');

  // Store FCM token in Firestore for logged-in user
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && token != null) {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'fcmToken': token,
    }, SetOptions(merge: true));
  }

  // Listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received FCM message in foreground: ${message.notification?.title}');
    // Optionally show a local notification here
    if (message.notification != null) {
      NotificationService.showInstantNotification(
        message.notification!.title ?? 'Notification',
        message.notification!.body ?? '',
      );
    }
  });

  // Listen for background/terminated messages
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('FCM notification clicked!');
    // TODO: Navigate to notification screen if needed
  });
}

class WilayatWayApp extends StatelessWidget {
  const WilayatWayApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wilayat Way',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/user_details': (context) => const UserDetailsScreen(),
      },
    );
  }
}
