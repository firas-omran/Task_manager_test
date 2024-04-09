import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/Auth/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(_loginButtonPressed);
    on<AppStartedEvent>(_appStartedEvent);
    on<LoggedOutEvent>(_loggedOutEvent);
  }

  _loginButtonPressed(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    try {
      final String token =
          await authRepository.logIn(event.email, event.password);
      if (!token.isEmpty) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: 'Login failed.'));
      }
    } catch (exception) {
      emit(LoginFailure(
        error: exception.toString(),
      ));
    }
  }

  _loggedOutEvent(LoggedOutEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await authRepository.logOut();
      emit(LoginUnauthenticated());
    } catch (exception) {
      emit(LoginFailure(
        error: exception.toString(),
      ));
    }
  }

  _appStartedEvent(AppStartedEvent event, Emitter<LoginState> emit) async {
    try {
      final bool hasToken = await authRepository.hasToken();
      if (hasToken) {
        emit(LoginSuccess());
      } else {
        emit(LoginUnauthenticated());
      }
    } catch (exception) {
      emit(LoginFailure(
        error: exception.toString(),
      ));
    }
  }
}
