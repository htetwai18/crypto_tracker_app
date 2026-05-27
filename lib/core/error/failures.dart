import 'package:equatable/equatable.dart';

/// Failures surfaced to the presentation layer.
sealed class Failure extends Equatable {
  const Failure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error'});
}

final class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error'});
}

final class NetworkUnavailableFailure extends Failure {
  const NetworkUnavailableFailure({
    super.message = 'Network unavailable — no cached data',
  });
}

final class RateLimitFailure extends Failure {
  const RateLimitFailure({
    super.message =
        'Too many requests. Please wait a moment before loading more.',
  });
}
