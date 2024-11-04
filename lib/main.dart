import 'package:expense_tracker/bloc/auth_bloc.dart';
import 'package:expense_tracker/bloc/auth_state.dart';
import 'package:expense_tracker/config/themes/app_theme.dart';
import 'package:expense_tracker/core/navigation/app_routes.dart';
import 'package:expense_tracker/fitness_app/fitness_app_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedStorage
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        themeMode: ThemeMode.system,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await isUserDataAvailable(context);
    if (isLoggedIn) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (route) => false);
      }
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    }
  }

  Future<bool> isUserDataAvailable(BuildContext context) async {
    // Access the current state of AuthBloc
    final state = context.read<AuthBloc>().state;

    if (state is AuthAuthenticated) {
      // Access the loginResponse data
      final loginResponse = state.loginResponse;
      print('loginResponse=============>>>>>>>>: $loginResponse');
      // Check if loginResponse contains the necessary user data
      // For example, check if a specific field exists
      return loginResponse
          .isNotEmpty; // Adjust this condition based on your data structure
    }

    return false; // Return false if the user is not authenticated
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.lightBlue),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
