import 'package:flutter/material.dart';

import '../dialogs/custom_dialog.dart';
import '../extensions/extensions.dart';
import '../services/firebase_auth_service.dart';
import '../validators/validators.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final formKey = GlobalKey<FormState>();

  final firebaseService = FirebaseService.instance;

  var email = '';
  var password = '';

  Future<void> _singIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final failure = await showBlurry(
      context,
      firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    if (!mounted) {
      return;
    }

    if (failure != null) {
      final errorData = failure.errorData;
      CustomDialog.show(
        context,
        title: errorData.message,
        icon: errorData.icon,
      );
      return;
    }

    context.pushReplacementNamed(HomeScreen.route);
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
            child: Form(
              key: formKey,
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
                      onChanged: (value) => setState(
                        () => email = value.trim(),
                      ),
                      validator: FormValidator.email,
                    ),
                    separator,
                    CustomImput.password(
                      onChanged: (value) => setState(
                        () => password = value.trim(),
                      ),
                      validator: FormValidator.password,
                    ),
                    separator,
                    CustomButton(
                      text: 'Login',
                      onPressed: _singIn,
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
      ),
    );
  }
}
