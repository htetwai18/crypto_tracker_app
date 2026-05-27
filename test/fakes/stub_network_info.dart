import 'dart:async';

import 'package:crypto_tracker_app/core/network/network_info.dart';

/// Simple [NetworkInfo] for tests.
final class StubNetworkInfo implements NetworkInfo {
  StubNetworkInfo({this.online = true});

  bool online;
  final _controller = StreamController<bool>.broadcast();

  void setOnline(bool value) {
    online = value;
    if (!_controller.isClosed) {
      _controller.add(value);
    }
  }

  @override
  Future<bool> get isConnected async => online;

  @override
  Stream<bool> get onConnectivityChanged async* {
    yield online;
    yield* _controller.stream;
  }
}
