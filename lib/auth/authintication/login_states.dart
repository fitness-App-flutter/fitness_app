part of 'login_cubit.dart';

abstract class LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSucess extends LoginStates {}

class LoginFalier extends LoginStates {
  String? errorMassage;
  LoginFalier({this.errorMassage});
}
