import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {
  final Map<String, dynamic> loginResponse;

  const AuthEvent({required this.loginResponse});
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required super.loginResponse});
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent({required super.loginResponse});
}
