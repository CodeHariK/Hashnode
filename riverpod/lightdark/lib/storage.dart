import 'package:lightdark/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage.g.dart';

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
