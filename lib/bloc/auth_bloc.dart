import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'auth_event.dart'; // Import AuthEvent
import 'auth_state.dart'; // Import AuthState

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // Debug: Log the incoming event
      print('Received event: $event');

      // Check if loginResponse is a Map<String, dynamic>
      final loginResponse = event.loginResponse;

      print(
          'Parsed login response (Map): $loginResponse'); // Debug: Log parsed response
      emit(AuthAuthenticated(
          loginResponse: loginResponse)); // Pass the Map directly
    });

    // logout event
    on<LogoutEvent>((event, emit) {
      emit(AuthInitial());
    });
  }

  // hydrate from json
  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    // Debug: Log the JSON being deserialized
    print('Deserializing from JSON: $json');
    return AuthAuthenticated.fromJson(json);
  }

  // convert state to json
  @override
  Map<String, dynamic>? toJson(AuthState state) {
    // Debug: Log the state being serialized
    print('Serializing state to JSON: $state');
    if (state is AuthAuthenticated) {
      return state.toJson();
    }
    return null; // Return null for other states
  }
}
