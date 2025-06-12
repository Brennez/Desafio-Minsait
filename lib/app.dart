import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app/presentation/pages/home_page/home_page_export.dart';

class App extends StatelessWidget {
  App({super.key});

  final GoRouter router = GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (context, state) {
          return HomePage();
        }),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
