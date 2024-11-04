import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  final String baseUrl;
  final CacheManager cacheManager;
  String? _authToken;

  ApiService(this.baseUrl) : cacheManager = DefaultCacheManager();

  Future<dynamic> fetcher({
    required String endpoint,
    Map<String, dynamic>? data,
    String contentType = 'application/json',
    String method = 'GET',
    String? bearerToken,
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No Internet Connection');
    }

    var url = Uri.parse('$baseUrl$endpoint');
    http.Response? response;

    var headers = {
      'Content-Type': contentType,
      if (bearerToken != null) 'Authorization': 'Bearer $bearerToken',
      if (_authToken != null) 'Authorization': 'Bearer $_authToken',
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
          response = await http.delete(url, headers: headers);
          break;
        case 'GET':
        default:
          var cachedResponse =
              await cacheManager.getFileFromCache(url.toString());
          if (cachedResponse != null) {
            return jsonDecode(await cachedResponse.file.readAsString());
          }

          response = await http.get(url, headers: headers);
          if (_isSuccessCode(response.statusCode)) {
            await cacheManager.putFile(url.toString(), response.bodyBytes);
          }
          break;
      }

      _handleCookies(response);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  bool _isSuccessCode(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  void _handleCookies(http.Response response) {
    var cookies = response.headers['set-cookie'];
    if (cookies != null) {
      var cookieParts = cookies.split(';');
      for (var part in cookieParts) {
        if (part.trim().startsWith('Authorization=')) {
          _authToken = part.split('=')[1].trim();
          break;
        }
      }
    }
  }

  dynamic _handleResponse(http.Response response) {
    var responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (e) {
      responseBody = response.body;
    }

    if (_isSuccessCode(response.statusCode)) {
      return responseBody;
    }

    switch (response.statusCode) {
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
        throw Exception(
            'Server Error: ${responseBody['message'] ?? response.body}');
      default:
        throw Exception('Error: ${responseBody['message'] ?? response.body}');
    }
  }

  Future<void> invalidateCache(String endpoint) async {
    var url = Uri.parse('$baseUrl$endpoint');
    await cacheManager.removeFile(url.toString());
  }
}
