import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool isPasswordVisible;
  final Function() togglePasswordVisibility;
  final FormFieldValidator<String> validate;
  final String name;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.isPasswordVisible = false,
    required this.togglePasswordVisibility,
    required this.validate,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      obscureText: isPassword ? !isPasswordVisible : false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: togglePasswordVisibility,
                icon: Icon(isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              )
            : null,
      ),
      validator: validate,
      onChanged: (value) {
        if (value != null) {
          validate(value);
        }
      },
    );
  }
}
