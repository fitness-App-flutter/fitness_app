import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PasswordService {
  static Future<String?> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
        return 'Please fill in all fields';
      }

      if (newPassword != confirmPassword) {
        return 'New passwords do not match';
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return 'User not logged in';

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      print('Reauthenticating with email: ${user.email}, password: $currentPassword');

      await user.reauthenticateWithCredential(credential);


      await user.updatePassword(newPassword);


      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'lastPasswordChange': FieldValue.serverTimestamp()});

      return null; // success

    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') return 'Incorrect current password';
      if (e.code == 'weak-password') return 'Use a stronger password (min 6 chars)';
      if (e.code == 'requires-recent-login') return 'Please log in again and try changing the password';
      return 'Firebase error: ${e.message}';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
