part of 'users_bloc.dart';

@immutable
abstract class UsersState extends Equatable {
  final List<UserModel> users;

  UsersState({required this.users});
}

final class FetchUsersSuccess extends UsersState {
  FetchUsersSuccess({required super.users});

  @override
  // TODO: implement props
  List<Object?> get props => [users];
}

final class LoadUserFailure extends UsersState {
  final String error;

  LoadUserFailure({required this.error, required super.users});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

final class UsersLoading extends UsersState {
  UsersLoading({required super.users});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class LoadMoreUserFailure extends UsersState {
  final String error;

  LoadMoreUserFailure({required this.error, required super.users});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

final class LoadMoreUserFinish extends UsersState {
  final String error;

  LoadMoreUserFinish({required this.error, required super.users});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

final class LoadMoreUserLoading extends UsersState {
  LoadMoreUserLoading({required super.users});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
