import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:gorouterauth/router.dart';
import 'package:gorouterauth/storage.dart';

init() {
  //your init logic
}

void main() async {
  //https://docs.flutter.dev/ui/navigation/url-strategies
  usePathUrlStrategy();

  await init();

  //ProviderContainer : If you want to use listen to provider without consumer widget,
  // and override specific scope of widget tree
  final container = ProviderContainer();

  //Initiate SharedPreferences Storage
  container.listen(storageProvider, (prev, next) {});

  //Initiate GoRouter Redirection Logic
  container.listen(routerRedirectorProvider, (prev, next) {});

  runApp(
    ProviderScope(
      parent: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GoRouterAuth',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
