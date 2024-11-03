import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  final String logoPath;
  final VoidCallback onLanguagePressed;

  const AuthHeader({
    super.key,
    required this.logoPath,
    required this.onLanguagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(logoPath),
          IconButton(
            onPressed: onLanguagePressed,
            icon: const Icon(Icons.language),
          ),
        ],
      ),
    );
  }
}
