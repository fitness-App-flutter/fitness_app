import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_states.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signUp({
     String? email,
     String? password,
     String? healthStatus,
     String? target,
     double? weight,
    required int height,
  }) async {
    try {

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      String uid = userCredential.user!.uid;
      print('User UID: ${userCredential.user?.uid}');
      print('Is Signed In: ${FirebaseAuth.instance.currentUser != null}');

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'healthStatus': healthStatus,
        'target': target,
        'weight': weight,
        'height': height,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('User data has been stored ✅');
    } on FirebaseAuthException catch (e) {
      print('SignUp faild: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }
}