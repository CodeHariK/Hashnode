import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouterauth/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

class Auth {
  static final routes = $appRoutes;
}

// Auth route
@TypedGoRoute<AuthRoute>(path: AppRouter.login)

//Auth Widget
class AuthRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer(
          builder: (context, ref, child) {
            return Center(
              child: FilledButton(
                onPressed: () {
                  ref.read(authenticationProvider.notifier).login();
                },
                child: const Text('Login'),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ------------ Authentication Provider
@Riverpod(keepAlive: true)
class Authentication extends _$Authentication {
  @override
  Future<bool> build() async {
    return false;
  }

  void login() async {
    // Handle your login logic
    await Future.delayed(const Duration(milliseconds: 300));

    state = const AsyncData(true);
  }

  void logout() async {
    // Handle your logout logic
    await Future.delayed(const Duration(milliseconds: 300));

    state = const AsyncData(false);
  }
}
