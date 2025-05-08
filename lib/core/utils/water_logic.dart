import 'package:cloud_firestore/cloud_firestore.dart';

class WaterLogic {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int?> getWaterCups(String userId) async {
    try {
      final today = DateTime.now();
      final dateKey = "${today.year}-${today.month}-${today.day}";

      final doc = await _firestore.collection("reports").doc(userId).collection("daily").doc(dateKey).get();

      if (doc.exists && doc.data()!.containsKey("waterCups")) {
        return doc["waterCups"];
      }
    } catch (e) {
      print("Error loading water cups: $e");
    }
    return null;
  }

  Future<void> updateWaterCups(String userId, int newCups) async {
    try {
      final today = DateTime.now();
      final dateKey = "${today.year}-${today.month}-${today.day}";

      await _firestore.collection("reports").doc(userId).collection("daily").doc(dateKey).set(
        {"waterCups": newCups},
        SetOptions(merge: true),
      );
    } catch (e) {
      print("Error updating water cups: $e");
    }
  }
}
