import 'package:dio/dio.dart';

import '../error/failures.dart';

Failure failureFromDio(DioException error) {
  final statusCode = error.response?.statusCode;
  if (statusCode == 429) {
    return const RateLimitFailure();
  }
  if (statusCode == 404) {
    return const ServerFailure(message: 'Requested coin data was not found.');
  }
  if (statusCode != null && statusCode >= 500) {
    return const ServerFailure(
      message: 'Server is temporarily unavailable. Please try again shortly.',
    );
  }
  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.sendTimeout) {
    return const NetworkUnavailableFailure(
      message: 'Request timed out. Please check your connection and retry.',
    );
  }
  if (error.type == DioExceptionType.connectionError) {
    return const NetworkUnavailableFailure(
      message: 'No internet connection. Showing cached data when available.',
    );
  }
  return ServerFailure(
    message:
        error.message ??
        'Something went wrong while contacting the server. Please retry.',
  );
}
