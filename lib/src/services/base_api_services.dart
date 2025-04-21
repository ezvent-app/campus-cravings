import 'package:http/http.dart';

abstract class BaseApiServices {
  Future<Response> postAPI({
    required String url,
    required Map<String, dynamic> map,
  });
  Future<Response> getAPI(String url);
  Future<Response> patchAPI({
    required String url,
    required Map<String, dynamic> map,
  });
  Future<Response> deleteAPI(String url);
}
