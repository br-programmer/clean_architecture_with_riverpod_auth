import 'package:flutter/material.dart';

import '../dialogs/dialogs.dart';
import '../extensions/extensions.dart';
import '../services/services.dart';
import '../validators/validators.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final formKey = GlobalKey<FormState>();
  final firebaseService = FirebaseService.instance;

  var email = '';
  var password = '';

  Future<void> _signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final failure = await showBlurry(
      context,
      firebaseService.createUserWithEmailAndPassword(
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
                      validator: FormValidator.email,
                    ),
                    separator,
                    CustomImput.password(
                      onChanged: (value) => setState(() => password = value),
                      validator: FormValidator.password,
                    ),
                    separator,
                    CustomImput.password(
                      hint: 'Confirm Password',
                      validator: (value) => FormValidator.confirmPassword(
                        value,
                        password,
                      ),
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
      ),
    );
  }
}
