import 'package:crypto_tracker_app/core/error/failures.dart';
import 'package:crypto_tracker_app/core/network/dio_failure_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DioException dioError({
    int? statusCode,
    DioExceptionType type = DioExceptionType.unknown,
    String? message,
  }) {
    return DioException(
      requestOptions: RequestOptions(path: '/'),
      type: type,
      message: message,
      response: statusCode == null
          ? null
          : Response(
              requestOptions: RequestOptions(path: '/'),
              statusCode: statusCode,
            ),
    );
  }

  test('maps 429 to RateLimitFailure', () {
    final failure = failureFromDio(dioError(statusCode: 429));
    expect(failure, isA<RateLimitFailure>());
  });

  test('maps timeout to NetworkUnavailableFailure', () {
    final failure = failureFromDio(
      dioError(type: DioExceptionType.connectionTimeout),
    );
    expect(failure, isA<NetworkUnavailableFailure>());
  });

  test('maps 404 to explicit server message', () {
    final failure = failureFromDio(dioError(statusCode: 404));
    expect(failure.message, 'Requested coin data was not found.');
  });
}
