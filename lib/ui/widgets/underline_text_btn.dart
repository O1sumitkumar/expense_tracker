import 'package:flutter/material.dart';

class UnderlineTextBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const UnderlineTextBtn(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        // padding: EdgeInsets.zero,
        textStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
