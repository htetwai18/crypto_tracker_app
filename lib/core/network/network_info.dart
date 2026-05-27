import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract — online when any non-none connectivity is reported.
abstract interface class NetworkInfo {
  Future<bool> get isConnected;

  /// Emits the current status immediately, then on every connectivity change.
  Stream<bool> get onConnectivityChanged;
}

final class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._connectivity);

  final Connectivity _connectivity;

  static bool _isOnline(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _isOnline(results);
  }

  @override
  Stream<bool> get onConnectivityChanged async* {
    yield await isConnected;
    await for (final results in _connectivity.onConnectivityChanged) {
      yield _isOnline(results);
    }
  }
}
