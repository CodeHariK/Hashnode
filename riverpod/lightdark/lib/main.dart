import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lightdark/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

@riverpod
String hello(HelloRef ref, String person) {
  final count = ref.watch(futureHelloProvider).value;

  return '$count $person';
}

@riverpod
Future<int> futureHello(FutureHelloRef ref) async {
  await Future.delayed(const Duration(seconds: 1));

  return Random().nextInt(100);
}

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final GlobalAppTheme globalAppTheme = ref.watch(globalThemeProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: globalAppTheme.theme.brightness,
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalAppTheme globalAppTheme = ref.watch(globalThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const HelloConsumer(),
      ),
      body: Column(
        children: [
          PopupMenuButton<ThemeType>(
            itemBuilder: (context) {
              return ThemeType.values
                  .map<PopupMenuEntry<ThemeType>>(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(e.name.toUpperCase()), e.icon],
                      ),
                    ),
                  )
                  .toList();
            },
            onSelected: (v) {
              ref.read(globalThemeProvider.notifier).setThemeType(v);
            },
            position: PopupMenuPosition.under,
            offset: const Offset(1, -120),
            child: ListTile(
              visualDensity: VisualDensity.compact,
              title: const Text('Theme'),
              subtitle: Text(globalAppTheme.theme.name),
              trailing: globalAppTheme.theme.icon,
            ),
          ),
        ],
      ),
    );
  }
}

class HelloConsumer extends ConsumerWidget {
  const HelloConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightdark = ref.watch(helloProvider('LightDark'));
    final futureHello = ref.watch(futureHelloProvider);

    return futureHello.when(
      data: (data) => InkWell(
        child: Text(lightdark),
        onTap: () {
          ref.invalidate(futureHelloProvider);
        },
      ),
      error: (error, stackTrace) => const Text('error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
