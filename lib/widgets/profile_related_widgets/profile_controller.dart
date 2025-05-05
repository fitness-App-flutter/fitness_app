import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends ChangeNotifier {
  // State fields
  bool _isPrivate = false;
  bool _isEditing = false;
  String _name = "";
  String _email = "";
  int _weight = 0;
  int _height = 0;
  String? _profileImageUrl;
  String? get profileImageUrl => _profileImageUrl;


  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getters
  bool get isPrivate => _isPrivate;
  bool get isEditing => _isEditing;
  String get name => _name;
  String get email => _email;
  int get weight => _weight;
  int get height => _height;

  // Constructor
  ProfileController() {
    _loadProfileData();
  }

  // Load user profile data
  Future<void> _loadProfileData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) return;

      final data = doc.data();
      _name = data?['name'] ?? "";
      _email = data?['email'] ?? user.email ?? "";
      _weight = (data?['weight'] ?? 0).toInt();
      _height = (data?['height'] ?? 0).toInt();
      _isPrivate = data?['isPrivate'] ?? false;
      _profileImageUrl = data?['profileImageUrl'];

      // Sync controllers
      nameController.text = _name;
      emailController.text = _email;
      weightController.text = _weight.toString();
      heightController.text = _height.toString();

    } catch (e) {
      print("Error loading profile data: $e");
    }

    notifyListeners();
  }

  // Update Firestore user data
  Future<void> _updateFirestoreData(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection('users').doc(user.uid).set(data, SetOptions(merge: true));
    } catch (e) {
      print("Error updating Firestore data: $e");
    }
  }
  Future<void> updateProfileImage(String imageUrl) async {
    _profileImageUrl = imageUrl;
    await _updateFirestoreData({'profileImageUrl': imageUrl});
    notifyListeners();
  }

  // Reauthentication
  Future<void> _reauthenticateIfNeeded(String? password) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      throw Exception("User or email is null.");
    }
    if (password == null || password.isEmpty) {
      throw Exception("Password required for reauthentication.");
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
    } catch (e) {
      throw Exception("Reauthentication failed: ${e.toString()}");
    }
  }

  // Email update
  Future<void> _updateEmail(String newEmail) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await user.updateEmail(newEmail);
    _email = newEmail;
    await _firestore.collection('users').doc(user.uid).update({'email': newEmail});
  }

  // Public update method
  Future<void> updateProfile({
    required String name,
    required String email,
    required int weight,
    required int height,
    bool? isPrivate,
    String? passwordForReauth,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final updateData = <String, dynamic>{};

    if (name != _name) {
      _name = name;
      updateData['name'] = name;
    }
    if (weight != _weight) {
      _weight = weight;
      updateData['weight'] = weight;
    }
    if (height != _height) {
      _height = height;
      updateData['height'] = height;
    }
    if (isPrivate != null && isPrivate != _isPrivate) {
      _isPrivate = isPrivate;
      updateData['isPrivate'] = isPrivate;
    }

    await _updateFirestoreData(updateData);

    if (email != _email && email != user.email) {
      try {
        await _reauthenticateIfNeeded(passwordForReauth);
        await _updateEmail(email);
      } catch (e) {
        throw Exception("Email update failed: ${e.toString()}");
      }
    }

    notifyListeners();
  }

  // Individual updates
  void updateWeight(int newWeight) {
    _weight = newWeight;
    _updateFirestoreData({'weight': newWeight});
    notifyListeners();
  }

  void updateHeight(int newHeight) {
    _height = newHeight;
    _updateFirestoreData({'height': newHeight});
    notifyListeners();
  }

  void togglePrivacy(bool value) {
    _isPrivate = value;
    _updateFirestoreData({'isPrivate': value});
    notifyListeners();
  }

  void toggleEditMode(bool value) {
    _isEditing = value;
    notifyListeners();
  }

  void reloadProfile() {
    _loadProfileData();
  }
}
