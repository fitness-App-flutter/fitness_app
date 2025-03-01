import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  bool _isPrivate = false;
  String _name = "Dean Winchester";
  String _email = "dean.winchester@example.com";
  double _weight = 70.0; // ✅ Use double instead of String
  double _height = 175.0; // ✅ Use double instead of String

  // Getters
  bool get isPrivate => _isPrivate;
  String get name => _name;
  String get email => _email;
  double get weight => _weight;
  double get height => _height;

  // Setters
  void togglePrivacy(bool value) {
    _isPrivate = value;
    notifyListeners();
  }

  void updateProfileInfo({
    String? name,
    String? email,
    double? weight, // ✅ Expect double
    double? height, // ✅ Expect double
  }) {
    _name = name ?? _name;
    _email = email ?? _email;
    _weight = weight ?? _weight;
    _height = height ?? _height;
    notifyListeners();
  }

  void updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (currentPassword.isEmpty) {
      debugPrint("Error: Current password cannot be empty!");
      return;
    }

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      debugPrint("Error: New passwords cannot be empty!");
      return;
    }

    if (newPassword == confirmPassword) {
      debugPrint("✅ Password updated successfully!");
    } else {
      debugPrint("❌ Error: Passwords do not match!");
    }
  }
}
