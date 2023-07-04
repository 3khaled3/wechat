// ignore_for_file: camel_case_types

part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class waitting extends AuthState {}
class success extends AuthState {}
class error extends AuthState {
  final String errorMessage;

  error(this.errorMessage);
}