import 'package:flutter/material.dart';
import 'package:git_app/app/presentation/pages/historic_page/historic_page.dart';
import 'package:go_router/go_router.dart';

import 'app/presentation/pages/home_page/home_page_export.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return HomePage();
    },
  ),
  GoRoute(
    path: '/historic',
    builder: (context, state) {
      return HistoricPage();
    },
  ),
]);

class App extends StatelessWidget {
  App({super.key});

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
