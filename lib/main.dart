import 'package:crypto_tracker_app/app/crypto_app.dart';
import 'package:crypto_tracker_app/di/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const CryptoApp());
}
