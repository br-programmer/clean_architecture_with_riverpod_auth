import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import 'screens.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const String route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Header(),
                  ElevatedButton(
                    onPressed: () => context.pushNamed(SignInScreen.route),
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.pushNamed(SignInScreen.route),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.theme.scaffoldBackgroundColor,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'By Flutter Dev, To Flutter Dev',
          style: TextStyle(
            fontSize: 14,
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The Flutter Community',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 60),
        Image.asset('assets/images/onboarding.png'),
        const SizedBox(height: 68),
      ],
    );
  }
}
