import 'package:campuscravings/src/src.dart';

class JWTDecoder {
  /// Decodes a Base64Url encoded string.
  static String decodeBase64Url(String input) {
    String normalized = base64Url.normalize(input);
    return utf8.decode(base64Url.decode(normalized));
  }

  /// Decodes the JWT token and extracts the payload.
  static Map<String, dynamic> decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      debugPrint('Invalid token');
    }

    final payload = decodeBase64Url(parts[1]);
    return json.decode(payload);
  }

  /// Checks if the token is expired.
  static bool isTokenExpired(String token) {
    final payload = decodeJWT(token);

    if (payload.containsKey('exp')) {
      int exp = payload['exp'];

      // Current time (in seconds since epoch)
      int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Return true if the current time is greater than the expiration time
      return currentTime > exp;
    }

    // If no 'exp' claim is present, treat the token as expired
    return true;
  }
}
