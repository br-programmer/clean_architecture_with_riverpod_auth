import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../services/firebase_auth_service.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onPressed: () => FirebaseService.instance.logout().whenComplete(
                    () => context.pushAndRemoveUntil(AuthScreen.route),
                  ),
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
