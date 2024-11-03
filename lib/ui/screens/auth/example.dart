import 'package:flutter/material.dart';
import 'package:glass/glass.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  bool effectEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/mountain.jpg'),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: TextButton(
                  onPressed: () =>
                      setState(() => effectEnabled = !effectEnabled),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(200),
                  ),
                  child: const Text(
                    "Night sky",
                    style: TextStyle(color: Colors.white),
                  ),
                ).asGlass(
                  enabled: effectEnabled,
                  tintColor: Colors.transparent,
                  clipBorderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
