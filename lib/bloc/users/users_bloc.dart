import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/users/user_model.dart';
import '../../repositories/users/user_repository.dart';

part 'users_event.dart';part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  int page = 1;
  ScrollController scrollController = ScrollController();
  final UserRepository userRepository;

  UsersBloc(this.userRepository) : super(FetchUsersSuccess(users: const [])) {
    scrollController.addListener(() {
      add(LoadMoreUserEvent());
    });
    on<FetchUserEvent>(_fetchUsers);
    on<LoadMoreUserEvent>(_loadMoreUsers);
  }

  void _fetchUsers(FetchUserEvent event, Emitter<UsersState> emit) async {
    emit(UsersLoading(users: const []));
    try {
      final users = await userRepository.getUsers(page);
      return emit(FetchUsersSuccess(users: users));
    } catch (exception) {
      emit(LoadUserFailure(error: exception.toString(), users: []));
    }
  }

  void _loadMoreUsers(LoadMoreUserEvent event, Emitter<UsersState> emit) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      emit(LoadMoreUserLoading(users: [...state.users]));
      page++;
      try {
        final users = await userRepository.getUsers(page);
        if (users.isEmpty)
          return emit(LoadMoreUserFinish(
              users: [...state.users, ...users],
              error: 'There are no more users'));
        return emit(FetchUsersSuccess(users: [...state.users, ...users]));
      } catch (exception) {
        emit(LoadMoreUserFailure(
            error: exception.toString(), users: [...state.users]));
      }
    }
  }
}
