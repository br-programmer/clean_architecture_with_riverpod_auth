import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import 'screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future<void>.delayed(
      const Duration(seconds: 3),
      () {
        final user = FirebaseAuth.instance.currentUser;
        final route = user != null ? HomeScreen.route : AuthScreen.route;
        context.pushReplacementNamed(route);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
