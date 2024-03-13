import 'package:flutter/material.dart';

import '../dialogs/dialogs.dart';
import '../extensions/extensions.dart';
import '../services/firebase_auth_service.dart';
import '../validators/validators.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String route = '/sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final formKey = GlobalKey<FormState>();

  final firebaseService = FirebaseService.instance;

  var email = '';
  var password = '';

  Future<void> signIn() async {
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
      FlutterMastersDialog.show(
        context,
        title: errorData.message,
        icon: errorData.icon,
      );
      return;
    }
    context.pushAndRemoveUntil(HomeScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

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
                      'Sign In',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      validator: FormValidator.email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Your email here',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      onChanged: (value) => setState(
                        () => email = value.trim(),
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      validator: FormValidator.password,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        hintText: 'Your password here',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                      ),
                      onChanged: (value) => setState(
                        () => password = value.trim(),
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: signIn,
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(height: 56),
                    FlutterMastersRichText(
                      text: 'Don’t have an Account?',
                      secondaryText: 'Sign Up',
                      onTap: () => context.pushNamed(SignUpScreen.route),
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
