import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerService {
  // Singleton instance
  static final LoggerService _instance = LoggerService._internal();

  // Private constructor
  LoggerService._internal();

  // Factory constructor to return the same instance
  factory LoggerService() => _instance;
  final _logger = Logger();
  // General log
  void log(dynamic message) {
    if (kDebugMode) {
      _logger.i(message);
    }
  }

  // Info log
  void info(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  // Warning log
  void warn(String message) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
    }
  }

  // Error log
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('StackTrace: $stackTrace');
    }
  }
}
