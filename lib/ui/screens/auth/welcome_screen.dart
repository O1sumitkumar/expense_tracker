import 'package:expense_tracker/ui/screens/auth/login_screen.dart';
import 'package:expense_tracker/ui/screens/auth/signup_screen.dart';
import 'package:expense_tracker/ui/widgets/auth_header.dart';
import 'package:expense_tracker/utils/custom_page_route.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AuthHeader(
              logoPath: 'assets/icons/Logo.svg',
              onLanguagePressed: () {},
            ),
            const Spacer(),
            //from here content will be in the middle
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'Welcome to Expense Tracker',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Your personal finance manager With intuitive features and smart predictions, users can effortlessly monitor their spending habits and plan for the future..!!',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            page: const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text('Get Started'),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            page: const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
