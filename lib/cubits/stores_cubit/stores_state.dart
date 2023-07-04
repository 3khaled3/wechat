// ignore_for_file: camel_case_types

part of 'stores_cubit.dart';

@immutable
abstract class StoresState {}

class StoresInitial extends StoresState {}

class success extends StoresState {}

class waitting extends StoresState {}

class error extends StoresState {
  final String errorMessage;

  error(this.errorMessage);
}

