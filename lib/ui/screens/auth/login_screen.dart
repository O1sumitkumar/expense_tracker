import 'package:expense_tracker/api/auth/auth_api.dart';
import 'package:expense_tracker/ui/screens/auth/signup_screen.dart';
import 'package:expense_tracker/ui/widgets/auth_header.dart';
import 'package:expense_tracker/ui/widgets/combination_text.dart';
import 'package:expense_tracker/ui/widgets/input_widget.dart';
import 'package:expense_tracker/utils/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool isPasswordVisible = false;

  void togglePasswordVisibility() =>
      setState(() => isPasswordVisible = !isPasswordVisible);

  // AuthApi instance
  final AuthApi authApi = AuthApi();

  Future<void> login() async {
    final email = _formKey.currentState!.fields['email']!.value;
    final password = _formKey.currentState!.fields['password']!.value;

    final response =
        await authApi.login({'email': email, 'password': password});
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                AuthHeader(
                  logoPath: 'assets/Logo.svg',
                  onLanguagePressed: () {},
                ),
                const Spacer(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text('Welcome back',
                            style: Theme.of(context).textTheme.headlineLarge),
                        const SizedBox(height: 10),
                        Text(
                          'Login to your account to continue',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        CustomTextField(
                          name: 'email',
                          label: 'Email',
                          icon: Icons.email_outlined,
                          isPassword: false,
                          togglePasswordVisibility: togglePasswordVisibility,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Email is required'),
                            FormBuilderValidators.email(
                                errorText: 'Invalid email format'),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          name: 'password',
                          label: 'Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          isPasswordVisible: isPasswordVisible,
                          togglePasswordVisibility: togglePasswordVisibility,
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Password is required'),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        CombinationText(
                          text: "Don't have an account?",
                          btnText: 'Signup',
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageRoute(page: const SignupScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(
                                  '${_formKey.currentState!.fields['email']!.value} ${_formKey.currentState!.fields['password']!.value}');
                              // Perform login action or navigate to the next screen
                            }
                            login();
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
        ),
      ),
    );
  }
}
