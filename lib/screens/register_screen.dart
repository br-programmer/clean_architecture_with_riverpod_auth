import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../extensions/num_x.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static String get route => '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = '';
  var password = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credentials.user;
      if (user != null) {
        context.pushNamed(HomeScreen.route);
      }
    } catch (_) {
      log(_.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final separator = 28.h;
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
                    'Signup',
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
                  const CustomImput.password(
                    hint: 'Confirm Password',
                  ),
                  separator,
                  CustomButton(
                    onPressed: _signUp,
                    text: 'Signup',
                  ),
                  separator,
                  separator,
                  CustomRichText(
                    firstText: 'Already have an Account?',
                    secondaryText: 'Login',
                    onTap: () {
                      context.pushReplacementNamed(LoginScreen.route);
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
