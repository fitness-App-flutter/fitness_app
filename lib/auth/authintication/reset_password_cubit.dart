import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_state.dart';
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _email;
  String? _verificationId;

  AuthCubit() : super(AuthInitial());

  Future<void> sendVerificationCode(String email) async {
    _email = email;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(EmailSent());
    } catch (e) {
      emit(AuthError('Sending email faild ${e.toString()}'));
    }
  }

  Future<void> verifyCode(String email) async {
    if (_email == email) {
      emit(CodeVerified());
    } else {
      emit(AuthError('Wrong email'));
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        emit(PasswordChanged());
      } else {
        emit(AuthError('User doesn\'t login'));
      }
    } catch (e) {
      emit(AuthError('Reset password failed: ${e.toString()}'));
    }
  }
}