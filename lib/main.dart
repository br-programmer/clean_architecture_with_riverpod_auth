import 'package:flutter/material.dart';

import 'screens/screens.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routes: <String, WidgetBuilder>{
        SplashScreen.route: (_) => const SplashScreen(),
        AuthScreen.route: (_) => const AuthScreen(),
        SignInScreen.route: (_) => const SignInScreen(),
        SignUpScreen.route: (_) => const SignUpScreen(),
        HomeScreen.route: (_) => const HomeScreen(),
      },
    );
  }
}
