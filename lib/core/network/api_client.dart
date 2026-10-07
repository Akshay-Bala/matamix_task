import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:matamix_task/core/constants/api_constants.dart';
import 'package:matamix_task/core/network/api_exceptions.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String url) async {
    try {
      final response = await _client
          .get(Uri.parse(url))
          .timeout(ApiConstants.timeoutDuration);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw RequestTimeoutException();
    } on http.ClientException {
      throw NetworkException();
    } on FormatException {
      throw ApiException('Invalid data format received from the server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('An unexpected error occurred: ${e.toString()}');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw ApiException('Failed to parse server response.');
      }
    } else if (response.statusCode == 404) {
      throw ServerException('Resource not found (404).', statusCode: 404);
    } else if (response.statusCode >= 500) {
      throw ServerException(
        'Server error (${response.statusCode}). Please try again later.',
        statusCode: response.statusCode,
      );
    } else {
      throw ServerException(
        'Request failed with status code ${response.statusCode}.',
        statusCode: response.statusCode,
      );
    }
  }
}
