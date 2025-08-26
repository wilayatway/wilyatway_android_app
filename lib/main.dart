import 'package:flutter/material.dart';
import 'package:wilayat_way_apk/screens/dashboard_screen.dart';
// import 'package:wilayat_way_apk/screens/pages/spiritualcontent/spiritual_content_screen.dart';
import 'package:wilayat_way_apk/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the Firebase options file
import 'package:wilayat_way_apk/screens/user_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await NotificationService.initialize();
    await NotificationService.scheduleAllNotifications();
    await NotificationService.requestNotificationPermission();
  
        await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions
              .currentPlatform, // This references the FirebaseOptions for your platform
    );
    // await uploadDaroodJsonToFirestore();

  } catch (e) {
    print("Error during initialization: $e");
  }
  runApp(const WilayatWayApp());
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
