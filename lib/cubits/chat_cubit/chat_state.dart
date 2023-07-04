// ignore_for_file: camel_case_types

part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class success extends ChatState {}

class waitting extends ChatState {}

class error extends ChatState {
  final String errorMessage;

  error(this.errorMessage);
}
