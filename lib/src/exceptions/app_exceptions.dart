abstract class AppException implements Exception {}

class ServerException extends AppException {}

class NetworkException extends AppException {}

class UnknownException extends AppException {}
