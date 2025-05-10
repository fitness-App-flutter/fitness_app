import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NutrientProvider with ChangeNotifier {
  int _fat = 0;
  int _protein = 0;
  int _carbs = 0;

  int get fat => _fat;
  int get protein => _protein;
  int get carbs => _carbs;
  int get totalCalories => (_fat * 9) + (_protein * 4) + (_carbs * 4);

  Future<void> loadData(String userId) async {
    final docId = _getTodayId();
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('calories')
        .doc(docId);

    final doc = await docRef.get();
    if (doc.exists) {
      final data = doc.data()!;
      _fat = (data['fat'] ?? 0).toInt();
      _protein = (data['protein'] ?? 0).toInt();
      _carbs = (data['carbs'] ?? 0).toInt();
    } else {
      _fat = 0;
      _protein = 0;
      _carbs = 0;
    }

    notifyListeners();
  }

  Future<void> updateNutrient(String type, int value, String userId) async {
    final int intValue = value.round();
    if (type == "Fat") _fat = (_fat + intValue).clamp(0, double.infinity).toInt();
    if (type == "Protein") _protein = (_protein + intValue).clamp(0, double.infinity).toInt();
    if (type == "Carbs") _carbs = (_carbs + intValue).clamp(0, double.infinity).toInt();

    await _saveToFirestore(userId);
    notifyListeners();
  }

  Future<void> resetValues(String userId) async {
    _fat = 0;
    _protein = 0;
    _carbs = 0;

    await _saveToFirestore(userId);
    notifyListeners();
  }

  Future<void> _saveToFirestore(String userId) async {
    final docId = _getTodayId();
    print("📝 Trying to save for userId: $userId on $docId");
    print("Saving values → Fat: $_fat, Protein: $_protein, Carbs: $_carbs, Calories: $totalCalories");

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('calories')
          .doc(docId)
          .set({
        'fat': _fat,
        'protein': _protein,
        'carbs': _carbs,
        'totalCalories': totalCalories,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Firestore: Save successful');
    } catch (e) {
      print('Firestore: Save failed → $e');
    }
  }

  String _getTodayId() {
    final now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }
}
