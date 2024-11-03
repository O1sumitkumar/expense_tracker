import 'dart:convert';
import 'package:expense_tracker/api/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  final String baseUrl;
  final CacheManager cacheManager;
  String? _authToken; // Variable to store the auth token

  ApiService(this.baseUrl) : cacheManager = DefaultCacheManager();

  Future<dynamic> fetcher({
    required String endpoint,
    Map<String, dynamic>? data,
    String contentType = 'application/json',
    String method = 'GET',
    String? bearerToken, // Add bearerToken parameter
  }) async {
    // Check for internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No Internet Connection');
    }

    // Set up request
    var url = Uri.parse('${AuthEndpoints.baseUrl}$endpoint');
    http.Response? response;

    // Set up headers
    var headers = {
      'Content-Type': contentType,
      if (bearerToken != null) 'Authorization': 'Bearer $bearerToken',
      if (_authToken != null)
        'Authorization': 'Bearer $_authToken', // Use stored token if available
    };

    try {
      switch (method.toUpperCase()) {
        case 'POST':
          response = await http.post(
            url,
            headers: headers,
            body: contentType == 'application/json' ? jsonEncode(data) : data,
          );
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: headers,
            body: contentType == 'application/json' ? jsonEncode(data) : data,
          );
          break;
        case 'DELETE':
          response = await http.delete(
            url,
            headers: headers,
          );
          break;
        case 'GET':
        default:
          // Check cache first
          var cachedResponse =
              await cacheManager.getFileFromCache(url.toString());
          if (cachedResponse != null) {
            return jsonDecode(await cachedResponse.file.readAsString());
          }

          response = await http.get(url, headers: headers);
          if (response.statusCode == 200) {
            await cacheManager.putFile(url.toString(), response.bodyBytes);
          }
          break;
      }

      // Handle cookies and extract the token
      _handleCookies(response);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void _handleCookies(http.Response response) {
    // Check if the response contains a 'set-cookie' header
    var cookies = response.headers['set-cookie'];
    if (cookies != null) {
      // Extract the token from the cookies (assuming it's in the format "token=value")
      // You may need to adjust this based on your cookie format
      var cookieParts = cookies.split(';');
      for (var part in cookieParts) {
        if (part.trim().startsWith('Authorization=')) {
          _authToken = part.split('=')[1].trim(); // Store the token
          break;
        }
      }
    }
  }

  dynamic _handleResponse(http.Response response) {
    var responseBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return responseBody;
      case 400:
        throw Exception(
            'Bad Request: ${responseBody['message'] ?? response.body}');
      case 401:
        throw Exception(
            'Unauthorized: ${responseBody['message'] ?? response.body}');
      case 403:
        throw Exception(
            'Forbidden: ${responseBody['message'] ?? response.body}');
      case 404:
        throw Exception(
            'Not Found: ${responseBody['message'] ?? response.body}');
      case 500:
      default:
        throw Exception(
            'Server Error: ${responseBody['message'] ?? response.body}');
    }
  }

  Future<void> invalidateCache(String endpoint) async {
    var url = Uri.parse('$baseUrl$endpoint');
    await cacheManager.removeFile(url.toString());
  }
}
