part of 'sign_up_cubit.dart';

abstract class SignUpStates {}

class SignUpLoading extends SignUpStates {}

class SignUpSucess extends SignUpStates {}

class SignUpFalier extends SignUpStates {
  String? errorMassage;
  SignUpFalier({this.errorMassage});
}
