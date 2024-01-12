import 'dart:math';

import 'package:apptheme/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

ValueNotifier<bool> darkMode = ValueNotifier(false);
ValueNotifier<bool> cupertino = ValueNotifier(true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge(
        [
          darkMode,
          cupertino,
        ],
      ),
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: darkMode.value ? Brightness.dark : Brightness.light,
            ),
            textTheme: TextTheme(
              headlineMedium: GoogleFonts.bungee(fontSize: 30),
              labelMedium: GoogleFonts.pacifico(fontSize: 20),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              shape: darkMode.value
                  ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
          builder: (context, child) {
            if (!cupertino.value) return child ?? const Scaffold();

            return CupertinoTheme(
              data: CupertinoThemeData(
                brightness: Theme.of(context).brightness,
                primaryColor: Theme.of(context).colorScheme.primary,
              ),
              child: child ?? const Scaffold(),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: ThemeBox(title: 'Default Theme')),

            //
            Theme(
              data: ThemeData(
                filledButtonTheme: FilledButtonThemeData(
                  style: FilledButton.styleFrom(
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  ),
                ),
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    shape: const OvalBorder(eccentricity: 1),
                  ),
                ),
              ),
              child: const Expanded(
                child: ThemeBox(
                  title: 'Overriding Theme, does not listen to app theme anymore.',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              darkMode.value = true;
              cupertino.value = !cupertino.value;
            },
            tooltip: 'Increment',
            icon: cupertino.value ? const Icon(Icons.check_circle) : const Icon(Icons.circle),
            label: const Text('Cupertino'),
          ),
          const SizedBox(width: 5),
          FloatingActionButton(
            onPressed: () {
              darkMode.value = !darkMode.value;
            },
            tooltip: 'Increment',
            child: const Icon(Icons.sunny_snowing),
          ),
        ],
      ),
    );
  }
}

TextEditingController textCon = TextEditingController(text: 'The Greatest Show on Earth');

class ThemeBox extends StatelessWidget {
  const ThemeBox({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Text((10 + Random().nextInt(50)).toString()),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Without Themedata'),
              Text('With Themedata', style: Theme.of(context).textTheme.headlineMedium),
              Text('With Themedata Extension', style: context.lm),
            ],
          ),
          const DefaultTabController(
            length: 3,
            child: TabBar.secondary(
              tabs: [
                Tab(
                  child: Text('Hello'),
                ),
                Tab(
                  child: Text('Hello'),
                ),
                Tab(
                  child: Text('Hello'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(onPressed: () {}, child: const Text('Hello')),
                ElevatedButton(onPressed: () {}, child: const Text('Hello')),
                OutlinedButton(onPressed: () {}, child: const Text('Hello')),
                TextButton.icon(onPressed: () {}, label: const Text('Hello'), icon: const Icon(Icons.star)),
              ],
            ),
          ),
          TextFormField(
            controller: textCon,
            decoration: const InputDecoration(label: Text('Text Form Field')),
          ),
          CupertinoTextField(
            controller: textCon,
            placeholder: 'Cupertino Text Field',
          ),
          CupertinoButton.filled(
            child: const Text('Dialog'),
            onPressed: () {
              if (Random().nextBool()) {
                showAdaptiveDialog<String>(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) => AlertDialog.adaptive(
                    title: const Text('AlertDialog Title'),
                    content: const Text('AlertDialog description'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('AlertDialog Title'),
                      content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Ok'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
