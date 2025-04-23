import 'dart:developer';

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;

  final String _baseUrl = "http://192.168.18.25:5000/api";
  HttpService._internal();

  final Map<String, String> _headers = {"Content-Type": "application/json"};

  void setToken(String token) {
    _headers["x-access-token"] = "$token";
    _headers["Authorization"] = "Bearer $token";
  }

  Future<void> loadToken() async {
    final token = StorageHelper().getAccessToken();
    if (token != null) {
      setToken(token);
    } else {
      log("Token Not Found");
    }
  }

  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse(_baseUrl + endpoint);
    try {
      final response = await http
          .get(url, headers: _headers)
          .timeout(const Duration(seconds: 30));
      log("GET response: ${response.body}");
      return response;
    } catch (e) {
      log("GET request error: $e");
      rethrow;
    }
  }

  Future<http.Response> postRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse(_baseUrl + endpoint);
    try {
      final response = await http
          .post(url, headers: _headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 60));
      log("POST response: ${response.body}");
      return response;
    } catch (e) {
      log("POST request error: $e");
      rethrow;
    }
  }

  Future<http.Response> putRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse(_baseUrl + endpoint);
    try {
      final response = await http
          .put(url, headers: _headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 60));
      log("PUT response: ${response.body}");
      return response;
    } catch (e) {
      log("PUT request error: $e");
      rethrow;
    }
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    final url = Uri.parse(_baseUrl + endpoint);
    try {
      final response = await http
          .delete(url, headers: _headers)
          .timeout(const Duration(seconds: 30));
      log("DELETE response: ${response.body}");
      return response;
    } catch (e) {
      log("DELETE request error: $e");
      rethrow;
    }
  }
}
