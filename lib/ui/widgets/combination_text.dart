import 'package:flutter/material.dart';

class CombinationText extends StatelessWidget {
  final String text;
  final String btnText;
  final VoidCallback onPressed;

  const CombinationText({
    super.key,
    required this.text,
    required this.btnText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(style: Theme.of(context).textTheme.bodyMedium, text),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
            btnText,
          ),
        ),
      ],
    );
  }
}
