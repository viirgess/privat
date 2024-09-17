import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:privat_test_task/core/di/di.dart';

import 'package:privat_test_task/presentation/pages/main_screen.dart';

Future<void> main() async {
  await dotenv.load();
  configureDependencies();

  runApp(const MaterialApp(home: MainScreen()));
}
