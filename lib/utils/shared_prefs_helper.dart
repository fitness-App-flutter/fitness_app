import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _prefKey = "preValue";

  Future<double> getPreviousValue() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getDouble(_prefKey) ?? 0.0;
  }

  Future<void> savePreviousValue(double value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setDouble(_prefKey, value);
  }
}