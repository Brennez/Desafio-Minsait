import 'package:flutter/material.dart';
import 'package:git_app/app.dart';
import 'package:git_app/core/dependecies/dependencies_export.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isBoxOpen('searchs')) {
    await Hive.openBox('searchs');
  }
  setupDependencies();
  runApp(App());
}
