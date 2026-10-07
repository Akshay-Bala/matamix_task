class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException([
    super.message = 'Unable to connect. Please check your internet connection and try again.',
  ]);
}

class ServerException extends ApiException {
  ServerException(
    super.message, {
    super.statusCode,
  });
}

class RequestTimeoutException extends ApiException {
  RequestTimeoutException([
    super.message = 'The server is taking too long to respond. Please try again.',
  ]);
}
