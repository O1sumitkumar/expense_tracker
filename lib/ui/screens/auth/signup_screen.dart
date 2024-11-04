import 'package:expense_tracker/api/auth/auth_api.dart';
import 'package:expense_tracker/bloc/auth_bloc.dart';
import 'package:expense_tracker/bloc/auth_event.dart';
import 'package:expense_tracker/core/navigation/app_routes.dart';
import 'package:expense_tracker/ui/screens/auth/login_screen.dart';
import 'package:expense_tracker/ui/widgets/auth_header.dart';
import 'package:expense_tracker/ui/widgets/combination_text.dart';
import 'package:expense_tracker/ui/widgets/input_widget.dart';
import 'package:expense_tracker/utils/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // this function is used to toggle the password visibility
  void togglePasswordVisibility() =>
      setState(() => isPasswordVisible = !isPasswordVisible);

  // this function is used to toggle the confirm password visibility
  void toggleConfirmPasswordVisibility() =>
      setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible);

  // this function is used to validate the confirm password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (_formKey.currentState!.fields['password']!.value != value) {
      return 'Passwords do not match';
    }
    return null;
  }

  // AuthApi instance
  final AuthApi authApi = AuthApi();

  // this function is used to signup
  Future<void> signup() async {
    final fullName = _formKey.currentState!.fields['fullName']!.value;
    final email = _formKey.currentState!.fields['email']!.value;
    final password = _formKey.currentState!.fields['password']!.value;

    try {
      final response = await authApi.signup({
        'name': fullName,
        'email': email,
        'password': password,
      });

      // Check if the response is a Map and contains a success indicator
      if (response is Map<String, dynamic>) {
        // Assuming the API returns a success field
        if (response['success'] == true) {
          context.read<AuthBloc>().add(LoginEvent(loginResponse: response));
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.home, (route) => false);
        } else {
          // Handle the case where the API indicates failure
          throw Exception(
              'Signup failed: ${response['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      print('Signup error: $e'); // Log the error
      // Optionally show an error message to the user
    }
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageRoute(
                                page: const LoginScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signup();
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
