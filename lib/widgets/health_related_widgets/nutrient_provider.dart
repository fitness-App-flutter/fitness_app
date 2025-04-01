import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutrientProvider with ChangeNotifier {
  double _fat = 0;
  double _protein = 0;
  double _carbs = 0;
  DateTime? _lastResetTime;

  double get fat => _fat;
  double get protein => _protein;
  double get carbs => _carbs;
  double get totalCalories => (_fat * 9) + (_protein * 4) + (_carbs * 4);

  NutrientProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _fat = prefs.getDouble('fat') ?? 0;
    _protein = prefs.getDouble('protein') ?? 0;
    _carbs = prefs.getDouble('carbs') ?? 0;

    final lastReset = prefs.getString('lastResetTime');
    if (lastReset != null) {
      _lastResetTime = DateTime.tryParse(lastReset);
      _checkReset();
    }

    notifyListeners();
  }

  void _checkReset() {
    final now = DateTime.now();
    if (_lastResetTime == null || now.difference(_lastResetTime!) >= const Duration(hours: 24)) {
      resetValues();
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fat', _fat);
    await prefs.setDouble('protein', _protein);
    await prefs.setDouble('carbs', _carbs);
    if (_lastResetTime != null) {
      await prefs.setString('lastResetTime', _lastResetTime!.toIso8601String());
    }
    notifyListeners();
  }

  void updateNutrient(String type, double value) {
    if (type == "Fat") _fat = (_fat + value).clamp(0.0, double.infinity);
    if (type == "Protein") _protein = (_protein + value).clamp(0.0, double.infinity);
    if (type == "Carbs") _carbs = (_carbs + value).clamp(0.0, double.infinity);

    saveData();
    notifyListeners();
  }

  Future<void> resetValues() async {
    _fat = 0;
    _protein = 0;
    _carbs = 0;
    _lastResetTime = DateTime.now();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastResetTime', _lastResetTime!.toIso8601String());
    await saveData();
  }
}