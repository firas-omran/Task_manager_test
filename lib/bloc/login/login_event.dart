part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressedEvent({required this.email, required this.password});
}

class LoggedInEvent extends LoginEvent {
  final String token;

  LoggedInEvent({required this.token});
}

class AppStartedEvent extends LoginEvent {}

class LoggedOutEvent extends LoginEvent {}
