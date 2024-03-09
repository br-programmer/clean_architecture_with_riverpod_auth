import 'package:clean_architecture_with_riverpod/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String get route => '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future<void>.delayed(
      const Duration(seconds: 3),
      () => context.pushReplacementNamed(AuthScreen.route),
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
