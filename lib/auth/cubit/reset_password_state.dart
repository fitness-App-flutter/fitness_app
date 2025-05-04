part of'reset_password_cubit.dart';
abstract class AuthState {}
class AuthInitial extends AuthState {}
class EmailSent extends AuthState {}
class CodeSent extends AuthState {}
class CodeVerified extends AuthState {}
class PasswordChanged extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}