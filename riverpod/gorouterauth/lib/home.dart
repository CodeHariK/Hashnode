import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouterauth/auth.dart';
import 'package:gorouterauth/onboard.dart';
import 'package:gorouterauth/router.dart';

part 'home.g.dart';

class Home {
  static final routes = $appRoutes;
}

@TypedGoRoute<HomeRoute>(
  path: AppRouter.home,
)

//
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home'),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                ref.read(authenticationProvider.notifier).logout();
              },
              child: const Text('Logout'),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                ref.read(onboardedProvider.notifier).set(false);
              },
              child: const Text('Onboarding false'),
            ),
          ],
        ),
      ),
    );
  }
}
