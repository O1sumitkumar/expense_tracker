import 'package:flutter/material.dart';
import 'package:glass/glass.dart';

class AuthLayout extends StatelessWidget {
  final Widget child; // Accept a child widget

  const AuthLayout({super.key, required this.child}); // Constructor with child

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.all(16.0), // Padding around the entire layout
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: child,
                      ).asGlass(
                        enabled: true,
                        tintColor: Colors.transparent,
                        clipBorderRadius: BorderRadius.circular(15.0),
                        frosted: true,
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    const SizedBox(height: 20), // Gap between children
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
