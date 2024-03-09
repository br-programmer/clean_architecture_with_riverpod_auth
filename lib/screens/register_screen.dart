import 'package:clean_architecture_with_riverpod/extensions/extensions.dart';
import 'package:clean_architecture_with_riverpod/screens/screens.dart';
import 'package:clean_architecture_with_riverpod/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static String get route => '/register';

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
                    'Signup',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  separator,
                  const CustomImput.email(),
                  separator,
                  const CustomImput.password(),
                  separator,
                  const CustomImput.password(
                    hint: 'Confirm Password',
                  ),
                  separator,
                  CustomButton(
                    onPressed: () {
                      context.pushReplacementNamed(HomeScreen.route);
                    },
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
