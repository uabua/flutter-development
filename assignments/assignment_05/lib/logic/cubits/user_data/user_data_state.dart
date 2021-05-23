part of 'user_data_cubit.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
}

class UserDataInitial extends UserDataState {
  @override
  List<Object> get props => [];
}

class UserDataLoaded extends UserDataState {
  final List<User> users;

  const UserDataLoaded({
    required this.users,
  });

  @override
  List<Object?> get props => [users];
}

class UserDataError extends UserDataState {
  final String message;

  const UserDataError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
