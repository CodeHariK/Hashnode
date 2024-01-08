import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouterauth/auth.dart';
import 'package:gorouterauth/error404.dart';
import 'package:gorouterauth/home.dart';
import 'package:gorouterauth/onboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

extension ValidateRouterState on GoRouterState {
  bool get isAuth => uri.path.contains('/auth');
  bool match(String path) => uri.path == path;
}

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static const String home = '/';

  static const String login = '/auth/login'; //auth prefix is important for auth routes

  static const String onboard = '/onboard';
}

final ValueNotifier<RoutingConfig> myConfig = ValueNotifier<RoutingConfig>(
  _generateRoutingConfig(authenticated: false, onboarded: false),
);

final GoRouter router = GoRouter.routingConfig(
  navigatorKey: AppRouter.rootNavigatorKey,
  routingConfig: myConfig,
  initialLocation: AppRouter.onboard,
  errorPageBuilder: (context, state) => const MaterialPage(child: Error404Page()),
  debugLogDiagnostics: true,
);

// If (not Onboarded) : go to onboarding
// If (onboarded) and (not authenticated) : (go to login) or (else go to home)
// If (not Authenticated) and (going to one of the auth routes), (let it go)
// If (not Authenticated) and (not going to one of the auth routes), (redirect to login)
// If (Authenticated) and (going to one of the auth routes), (redirect to home)
// If (Authenticated) and (not going to one of the auth routes), (let it go)
RoutingConfig _generateRoutingConfig({required bool authenticated, required bool onboarded}) {
  return RoutingConfig(
    redirectLimit: 100,
    redirect: (context, state) async {
      debugPrint('-> -> -> ${state.uri}  ${state.isAuth}  auth:$authenticated onboard:$onboarded}');

      if (!onboarded) return AppRouter.onboard;
      if (state.match(AppRouter.onboard)) return authenticated ? AppRouter.home : AppRouter.login;

      if (!authenticated && !state.isAuth) return AppRouter.login;
      if (!authenticated && state.isAuth) return null;
      if (authenticated && state.isAuth) return AppRouter.home;
      if (authenticated && !state.isAuth) return null;

      return null;
    },
    routes: <RouteBase>[
      if (authenticated) ...Home.routes,
      if (!authenticated) ...Auth.routes,
      if (!onboarded) ...Onboard.routes,
    ],
  );
}

// Listens to auth and onboarding provider and rebuilds gorouter whenever they change.
@Riverpod(keepAlive: true)
Future routerRedirector(RouterRedirectorRef ref) async {
  final onboarded = ref.watch(onboardedProvider);
  final authenticated = ref.watch(authenticationProvider).value ?? false;

  myConfig.value = _generateRoutingConfig(
    authenticated: authenticated,
    onboarded: onboarded,
  );
}
