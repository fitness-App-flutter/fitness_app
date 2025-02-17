import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginLoading());

  Future<void> LoginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential users = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //User? user = FirebaseAuth.instance.currentUser;
      emit(LoginSucess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFalier(errorMassage: e.toString()));
      } else if (e.code == 'wrong-password') {
        emit(LoginFalier(errorMassage: e.toString()));
      }
    } catch (e) {
      emit(LoginFalier(errorMassage: 'someThing went wrong'));
    }
  }
}
