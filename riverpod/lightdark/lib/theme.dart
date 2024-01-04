// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:lightdark/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

enum ThemeType {
  system(Icon(CupertinoIcons.cloud_sun_rain)),
  dark(Icon(CupertinoIcons.moon_stars)),
  light(Icon(CupertinoIcons.sun_min));

  final Icon icon;

  const ThemeType(this.icon);

  static ThemeType from(String? v) {
    v = v ?? ThemeType.system.toString();

    return ThemeType.values.where((e) => e.toString() == v).first;
  }

  Brightness get brightness {
    if (this == ThemeType.dark) {
      return Brightness.dark;
    }
    if (this == ThemeType.light) {
      return Brightness.light;
    }
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }
}

class GlobalAppTheme {
  final ThemeType theme;

  GlobalAppTheme({
    required this.theme,
  });

  GlobalAppTheme copyWith({
    ThemeType? theme,
  }) {
    return GlobalAppTheme(
      theme: theme ?? this.theme,
    );
  }
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
