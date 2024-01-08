# Go Router Auth

Read code to understand.

[https://github.com/CodeHariK/Hashnode/blob/main/riverpod/gorouterauth/README.md](https://github.com/CodeHariK/Hashnode/blob/main/riverpod/gorouterauth/README.md)

## Overview

1.Look pubspec for all dependencies.

cli command to run build runner

dart run build_runner watch --delete-conflicting-outputs

2.App Structure

    Onboard -> Login -> Home

3.Riverpod [ProviderContainer](https://riverpod.dev/docs/concepts/scopes)

    ```dart
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
    ```

4.GoRouter

    ```dart
        MaterialApp.router(
            routerConfig: router,
    ```

    ```dart
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
    ```

    ```dart
        final ValueNotifier<RoutingConfig> myConfig = ValueNotifier<RoutingConfig>(
            _generateRoutingConfig(authenticated: false, onboarded: false),
        );
    ```

    ```dart
        final GoRouter router = GoRouter.routingConfig(
            navigatorKey: AppRouter.rootNavigatorKey,
            routingConfig: myConfig,
            initialLocation: AppRouter.onboard,
    ```

    ```dart
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
    ```
