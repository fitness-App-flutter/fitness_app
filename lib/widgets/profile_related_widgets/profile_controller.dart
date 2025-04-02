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

  // This method will toggle the privacy setting and notify listeners
  void togglePrivacy(bool value) {
    _isPrivate = value;
    notifyListeners();  // Notify listeners when privacy changes
  }

  // Load the profile data from SharedPreferences and update controllers
  void _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? "John Doe";
    _email = prefs.getString('email') ?? "johndoe@example.com";
    _weight = prefs.getDouble('weight') ?? 70.0;
    _height = prefs.getDouble('height') ?? 175.0;
    _isPrivate = prefs.getBool('isPrivate') ?? false;  // Load privacy setting

    nameController.text = _name;
    emailController.text = _email;
    weightController.text = _weight.toString();
    heightController.text = _height.toString();

    notifyListeners();  // Notify listeners after loading data
  }

  // Reload profile data from SharedPreferences
  void reloadProfile() {
    _loadProfileData();
  }

  // Update profile data and save it to SharedPreferences
  Future<void> updateProfile({
    String? name,
    String? email,
    double? weight,
    double? height,
    bool? isPrivate,  // Update privacy setting as well
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
    if (isPrivate != null) {
      _isPrivate = isPrivate;
      await prefs.setBool('isPrivate', isPrivate);
    }

    notifyListeners();  // Notify listeners after updating data
  }

  // Update weight and notify listeners
  void updateWeight(double newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  // Update height and notify listeners
  void updateHeight(double newHeight) {
    _height = newHeight;
    notifyListeners();
  }
}

