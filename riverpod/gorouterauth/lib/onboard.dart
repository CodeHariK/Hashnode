import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouterauth/router.dart';
import 'package:gorouterauth/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboard.g.dart';

class Onboard {
  static final routes = $appRoutes;
}

// ------------ Onboarding route
@TypedGoRoute<OnboardRoute>(path: AppRouter.onboard)
@immutable
class OnboardRoute extends GoRouteData {
  static final GlobalKey<NavigatorState> $parentNavigatorKey = AppRouter.rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OnboardingPage();
  }
}

// ------------ Onboarding provider
@Riverpod(keepAlive: true)
class Onboarded extends _$Onboarded {
  @override
  bool build() {
    ref.watch(storageProvider);
    return ref.read(storageProvider.notifier).getOnboard();
  }

  void set(bool onboarded) {
    state = onboarded;
    ref.read(storageProvider.notifier).saveOnboard(state);
  }
}

// ------------ Onboarding page
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('onboarding'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(onboardedProvider.notifier).set(true);
        },
        label: const Text('Continue'),
      ),
    );
  }
}
