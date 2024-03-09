import 'dart:developer';

import 'package:clean_architecture_with_riverpod/extensions/extensions.dart';
import 'package:clean_architecture_with_riverpod/screens/screens.dart';
import 'package:clean_architecture_with_riverpod/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String get route => '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = '';
  var password = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credentials.user;
      if (user != null) {
        context.pushReplacementNamed(HomeScreen.route);
      }
    } catch (_) {
      log(_.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const separator = SizedBox(height: 28);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  separator,
                  CustomImput.email(
                    onChanged: (value) => setState(() => email = value),
                  ),
                  separator,
                  CustomImput.password(
                    onChanged: (value) => setState(() => password = value),
                  ),
                  separator,
                  CustomButton(
                    text: 'Login',
                    onPressed: _login,
                  ),
                  separator,
                  separator,
                  CustomRichText(
                    firstText: 'Don’t have an Account?',
                    secondaryText: 'Signup',
                    onTap: () {
                      context.pushReplacementNamed(RegisterScreen.route);
                    },
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
