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

  //Onboard
  static const String _onboard = 'onboard';
  Future<void> saveOnboard(bool onboard) async => await _pref?.setBool(_onboard, onboard);
  bool getOnboard() => _pref?.getBool(_onboard) ?? false;
}
