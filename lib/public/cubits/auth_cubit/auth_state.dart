// ignore_for_file: must_be_immutable

part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  String errMessage;

  AuthFailure({required this.errMessage});
}

final class PasswordHidenState extends AuthState {}

final class PasswordShowenState extends AuthState {}

final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}
