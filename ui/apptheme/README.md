# App Theme

[Use themes to share colors and font styles](https://docs.flutter.dev/cookbook/design/themes)

[![Watch the video](https://img.youtube.com/vi/oTvQDJOBXmM/maxresdefault.jpg)](https://youtu.be/oTvQDJOBXmM)
[![Watch the video](https://img.youtube.com/vi/sA5MRFFUuOU/maxresdefault.jpg)](https://youtu.be/sA5MRFFUuOU)

To share colors and font styles throughout an app, use themes.

You can define app-wide themes. You can extend a theme to change a theme style for one component. Each theme defines the colors, type style, and other parameters applicable for the type of Material component.

Flutter applies styling in the following order:

Styles applied to the specific widget.
Themes that override the immediate parent theme.
Main theme for the entire app.

## Theme

```dart
    MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: darkMode.value ? Brightness.dark : Brightness.light,
            ),
            textTheme: TextTheme(
                headlineMedium: GoogleFonts.bungee(fontSize: 30),
                labelMedium: GoogleFonts.pacifico(fontSize: 20),
            ),
        ),
```

Most instances of ThemeData set values for the following two properties. These properties affect the entire app.

colorScheme defines the colors.
textTheme defines text styling.

## [Typography](https://docs.flutter.dev/ui/design/text/typography)

```dart
    extension SuperThemeData on BuildContext {
        TextStyle? get hm => Theme.of(this).textTheme.headlineMedium;
        TextStyle? get lm => Theme.of(this).textTheme.labelMedium;
    }

    const Text('Without Themedata'),
    Text('With Themedata', style: Theme.of(context).textTheme.headlineMedium),
    Text('With Themedata Extension', style: context.lm),

    # Use extension to make it compact 
    Theme.of(context).textTheme.headlineMedium ----> context.hm
```

## CupertinoTheme class

Applies a visual styling theme to descendant Cupertino widgets.

Affects the color and text styles of Cupertino widgets whose styling are not overridden when constructing the respective widgets instances.

Cupertino Widgets dont follow Material Theme, so we have to give theme CupertinoTheme.

```dart
    builder: (context, child) {
        return CupertinoTheme(
            data: CupertinoThemeData(
                brightness: Theme.of(context).brightness,
                primaryColor: Theme.of(context).colorScheme.primary,
            ),
            child: child ?? const Scaffold(),
        );
    },
```

Now cupertino widgets will adapt to material theme brightness and color.
