part of 'todo_data_cubit.dart';

abstract class TodoDataState extends Equatable {
  const TodoDataState();
}

class TodoDataInitial extends TodoDataState {
  @override
  List<Object> get props => [];
}

class TodoDataLoaded extends TodoDataState {
  final List<Todo> todos;

  const TodoDataLoaded({
    required this.todos,
  });

  @override
  List<Object?> get props => [todos];
}

class TodoDataError extends TodoDataState {
  final String message;

  const TodoDataError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
