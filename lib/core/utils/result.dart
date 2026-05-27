import '../error/failures.dart';

/// Lightweight result type — avoids extra dependencies.
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  Ok<T>? get ok => this is Ok<T> ? this as Ok<T> : null;
  Err<T>? get err => this is Err<T> ? this as Err<T> : null;
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}

extension ResultX<T> on Result<T> {
  R fold<R>(R Function(Failure f) err, R Function(T v) ok) =>
      switch (this) {
        Ok(:final value) => ok(value),
        Err(:final failure) => err(failure),
      };

  Failure? failureOrNull() => switch (this) {
    Err(:final failure) => failure,
    Ok() => null,
  };

  T? valueOrNull() => switch (this) {
    Ok(:final value) => value,
    Err() => null,
  };
}
