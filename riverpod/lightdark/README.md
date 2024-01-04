# LightDark

1. Install dependencies

    ```dart
        flutter create lightdark

        flutter pub add flutter_riverpod riverpod_annotation, shared_preferences
        flutter pub add dev:custom_lint dev:riverpod_lint dev:build_runner dev:riverpod_generator

        # Add to analysis_options.yaml
        analyzer:
        plugins:
            - custom_lint

        # Command to run build_runner:
        dart run build_runner watch --delete-conflicting-outputs

        # Add VsCode Extention
        Flutter Riverpod Snippets
    ```

2. Adding Provider Scope

    ```dart
        For widgets to be able to read providers, we need to wrap the entire application in a "ProviderScope" widget. This is where the state of our providers will be stored.

        void main() {
            runApp(
                const ProviderScope(
                    child: MyApp(),
                ),
            );
        }
    ```

3. Add part file directive on top of file and import dependencies.

    ```dart
        ###################(shortcut: riverpodPart)

        part 'main.g.dart';

        import 'package:flutter_riverpod/flutter_riverpod.dart';
        import 'package:riverpod_annotation/riverpod_annotation.dart';
    ```

4. Providers

    Providers are the most important part of a Riverpod application. A provider is an object that encapsulates a piece of state and allows listening to that state.

    * Allows easily accessing that state in multiple locations. Providers are a complete replacement for patterns like Singletons, Service Locators, Dependency Injection or InheritedWidgets.

    * Simplifies combining this state with others. Ever struggled to merge multiple objects into one? This scenario is built directly inside providers.

    * Enables performance optimizations. Whether for filtering widget rebuilds or for caching expensive state computations; providers ensure that only what is impacted by a state change is recomputed.

5. General provider syntax

    ```dart
        Simplest provider which does nothing more than returning a constant or running a synchronous function.
    
        ###################(shortcut: riverpod)
    
        @riverpod
        MyValue my(MyRef ref) {
            return MyValue();
        }

        Example

        @riverpod
            String hello(HelloRef ref, String name) {
            return '${Random().nextInt(100)} Hello $name';
        }

    ```

    ```dart
        FutureProvider is the equivalent of Provider but for asynchronous code.

        ###################(shortcut: riverpodFuture)

        @riverpod
        Future<MyValue> my(MyRef ref) async {

            await someFunction();

            return MyValue();
        }

        #Example

        @riverpod
        Future<String> futureHello(FutureHelloRef ref, String name) async {
            await Future.delayed(const Duration(seconds: 2));

            return '${Random().nextInt(100)} Hello $name';
        }
    ```

    ```dart
        Class based provider are like above ordinary provider can contain few functions.

        ###################(shortcut: riverpodAsyncClassKeepAlive)

        @Riverpod(keepAlive: true)
        class Storage extends _$Storage {
            SharedPreferences? get _pref => state.value;

            @override
            Future<SharedPreferences> build() async {
                SharedPreferences pref = await SharedPreferences.getInstance();

                return pref;
            }

            //Theme
            static const String _theme = 'theme';
            Future<void> saveTheme(ThemeType theme) async => await _pref?.setString(_theme, theme.toString());
            ThemeType getTheme() => ThemeType.from(_pref?.getString(_theme));
        }
    ```

6. Providers watching Providers

    ```dart

        Providers can watch each other and rebuild accordingly.
        To watch a provider use

        ref.watch(someProvider);

        Example

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

        Here hello is watching futureHello

        Whenever futureHello change hello will also rebuild itself.

    ```

7. Consumers

    Watching providers in widgets

    ```dart
        ConsumerWidget
        ###################(shortcut: stlessConsumer)
        
        Example

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
    ```

8. Now returning back to LightDark

    ```dart

    We have a storageProvider which initializes SharedPreferences which we will use to store theme information.
    We have another provider called GlobalTheme, which exposes a method to change theme and save it in SharedPreferences.

    @Riverpod(keepAlive: true)
    class Storage extends _$Storage {
        SharedPreferences? get _pref => state.value;

        @override
        Future<SharedPreferences> build() async {
            SharedPreferences pref = await SharedPreferences.getInstance();

            return pref;
        }

        //Theme
        static const String _theme = 'theme';
        Future<void> saveTheme(ThemeType theme) async => await _pref?.setString(_theme, theme.toString());
        ThemeType getTheme() => ThemeType.from(_pref?.getString(_theme));
    }

    @Riverpod(keepAlive: true)
    class GlobalTheme extends _$GlobalTheme {
        @override
        GlobalAppTheme build() {
            ref.watch(storageProvider);
            ThemeType theme = ref.read(storageProvider.notifier).getTheme();
            return GlobalAppTheme(
            theme: theme,
            );
        }

        void setThemeType(ThemeType theme) {
            state = state.copyWith(theme: theme);
            ref.read(storageProvider.notifier).saveTheme(state.theme);
        }
    }

    ```

9. To change theme

    ```dart
        ref.read(globalThemeProvider.notifier).setThemeType(v);
    ```

10. To watch theme

    ```dart
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

    ```
