import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  bool _isPrivate = false;
  String _name = "John Doe";
  String _email = "johndoe@example.com";
  double _weight = 70.0;
  double _height = 175.0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  bool get isPrivate => _isPrivate;
  String get name => _name;
  String get email => _email;
  double get weight => _weight;
  double get height => _height;

  ProfileController() {
    _loadProfileData();
  }

  void togglePrivacy(bool value) {
    _isPrivate = value;
    notifyListeners();
  }

  void _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? "John Doe";
    _email = prefs.getString('email') ?? "johndoe@example.com";
    _weight = prefs.getDouble('weight') ?? 70.0;
    _height = prefs.getDouble('height') ?? 175.0;

    nameController.text = _name;
    emailController.text = _email;
    weightController.text = _weight.toString();
    heightController.text = _height.toString();

    notifyListeners();
  }

  void reloadProfile() {
    _loadProfileData();
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    double? weight,
    double? height,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (name != null) {
      _name = name;
      await prefs.setString('name', name);
    }
    if (email != null) {
      _email = email;
      await prefs.setString('email', email);
    }
    if (weight != null) {
      _weight = weight;
      await prefs.setDouble('weight', weight);
    }
    if (height != null) {
      _height = height;
      await prefs.setDouble('height', height);
    }

    notifyListeners();
  }


  void updateWeight(double newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  void updateHeight(double newHeight) {
    _height = newHeight;
    notifyListeners();
  }
}