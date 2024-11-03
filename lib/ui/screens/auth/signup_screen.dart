import 'package:expense_tracker/ui/screens/auth/login_screen.dart';
import 'package:expense_tracker/ui/widgets/auth_header.dart';
import 'package:expense_tracker/ui/widgets/combination_text.dart';
import 'package:expense_tracker/ui/widgets/input_widget.dart';
import 'package:expense_tracker/utils/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility() =>
      setState(() => isPasswordVisible = !isPasswordVisible);
  void toggleConfirmPasswordVisibility() =>
      setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible);

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (_formKey.currentState!.fields['password']!.value != value) {
      return 'Passwords do not match';
    }
    return null;
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
                        Text(
                          'Start your journey',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Create your account to get started',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        CustomTextField(
                          name: 'fullName',
                          label: 'Full Name',
                          icon: Icons.person_outline,
                          isPassword: false,
                          togglePasswordVisibility: () {},
                          validate: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Full name is required'),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          name: 'email',
                          label: 'Email',
                          icon: Icons.email_outlined,
                          isPassword: false,
                          togglePasswordVisibility: () {},
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
                        const SizedBox(height: 20),
                        CustomTextField(
                          name: 'confirmPassword',
                          label: 'Confirm Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          isPasswordVisible: isConfirmPasswordVisible,
                          togglePasswordVisibility:
                              toggleConfirmPasswordVisibility,
                          validate: validateConfirmPassword,
                        ),
                        const SizedBox(height: 10),
                        CombinationText(
                          text: "Already have an account?",
                          btnText: 'Login',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(
                                  '${_formKey.currentState!.fields['fullName']!.value} ${_formKey.currentState!.fields['email']!.value} ${_formKey.currentState!.fields['password']!.value} ${_formKey.currentState!.fields['confirmPassword']!.value}');
                              Navigator.push(
                                context,
                                CustomPageRoute(
                                  page: const LoginScreen(),
                                ),
                              );
                            }
                          },
                          child: const Text('Signup'),
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
