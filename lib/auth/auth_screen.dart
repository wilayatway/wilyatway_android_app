import 'package:flutter/material.dart';
import 'package:wilayat_way_apk/auth/login_screen.dart';
import 'package:wilayat_way_apk/auth/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLogin = true;

  void toggle() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showLogin
          ? LoginScreen(onSwitch: toggle)
          : SignupScreen(onSwitch: toggle),
    );
  }
}
