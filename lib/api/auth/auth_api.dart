import 'package:expense_tracker/api/endpoints.dart';
import 'package:expense_tracker/api/services/fetcher.dart';

// This class is responsible for all the authentication related APIs
class AuthApi {
  // ApiService instance
  final ApiService apiService = ApiService(AuthEndpoints.baseUrl);

  // Signup
  Future<dynamic> signup(Map<String, dynamic> data) async {
    return await apiService.fetcher(
      endpoint: AuthEndpoints.signup,
      data: data,
      method: 'POST',
    );
  }

  // Login
  Future<dynamic> login(Map<String, dynamic> data) async {
    return await apiService.fetcher(
      endpoint: AuthEndpoints.login,
      data: data,
      method: 'POST',
    );
  }
}
