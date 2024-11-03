import 'package:expense_tracker/fitness_app/fitness_app_home_screen.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/ui/screens/auth/login_screen.dart';
import 'package:expense_tracker/ui/screens/auth/signup_screen.dart';
import 'package:expense_tracker/ui/screens/auth/welcome_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String welcome = '/welcome';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const FitnessAppHomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      default:
        // Handle unknown routes
        return MaterialPageRoute(
            builder: (_) => const LoginScreen()); // Fallback to LoginScreen
    }
  }
}
