import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message ?? 'Something went wrong'));
    } catch (e) {
      emit(LoginFailure('Unexpected error: ${e.toString()}'));
    }

  }
}