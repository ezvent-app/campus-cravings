import 'dart:developer';

import 'package:campuscravings/src/src.dart';
import 'package:http/http.dart' as http;

class HttpAPIServices extends BaseApiServices {
  final HttpService service = HttpService();
  late SharedPreferences pref;
  @override
  Future<http.Response> deleteAPI(String url) async {
    try {
      await service.loadToken();
      final response = await service.deleteRequest(url);
      return response;
    } catch (e) {
      log("Error in DELETE request: $e");
      throw _handleException(e);
    }
  }

  @override
  Future<http.Response> getAPI(String url) async {
    try {
      await service.loadToken();
      final response = await service.getRequest(url);
      return response;
    } catch (e) {
      log("Error in GET request: $e");
      throw _handleException(e);
    }
  }

  @override
  Future<http.Response> postAPI({
    required String url,
    required Map<String, dynamic> map,
  }) async {
    try {
      await service.loadToken();
      final response = await service.postRequest(url, map);
      return response;
    } catch (e) {
      log("Error in POST request: $e");
      throw _handleException(e);
    }
  }

  @override
  Future<http.Response> patchAPI({
    required String url,
    required Map<String, dynamic> map,
  }) async {
    try {
      await service.loadToken();
      final response = await service.patchRequest(url, map);
      return response;
    } catch (e) {
      log("Error in PATCH request: $e");
      throw _handleException(e);
    }
  }

  _handleException(dynamic e) {
    if (e is http.ClientException) {
      return const NetworkFailure();
    } else if (e is http.Response && e.statusCode >= 500) {
      return const ServerFailure();
    } else {
      return const UnknownFailure();
    }
  }
}
