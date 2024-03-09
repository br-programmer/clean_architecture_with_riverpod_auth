import 'package:clean_architecture_with_riverpod/screens/screens.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF262626),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFF58AE7A),
          secondary: const Color(0xFF454545),
        ),
      ),
      routes: <String, WidgetBuilder>{
        SplashScreen.route: (_) => const SplashScreen(),
        AuthScreen.route: (_) => const AuthScreen(),
        LoginScreen.route: (_) => const LoginScreen(),
        RegisterScreen.route: (_) => const RegisterScreen(),
        HomeScreen.route: (_) => const HomeScreen(),
      },
    );
  }
}
