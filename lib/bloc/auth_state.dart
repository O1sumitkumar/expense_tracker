import 'package:meta/meta.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Map<String, dynamic> loginResponse; // Store the login response

  const AuthAuthenticated({required this.loginResponse});

  factory AuthAuthenticated.fromJson(Map<String, dynamic> json) {
    return AuthAuthenticated(
      loginResponse: json['loginResponse'], // Deserialize login response
    );
  }

  Map<String, dynamic> toJson() => {
        'loginResponse': loginResponse, // Serialize login response
      };
}
