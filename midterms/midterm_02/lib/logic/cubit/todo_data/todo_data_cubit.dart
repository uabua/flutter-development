import 'package:midterm_02/data/models/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/data/repositories/todo_repository.dart';

part 'todo_data_state.dart';

class TodoDataCubit extends Cubit<TodoDataState> {
  TodoDataCubit() : super(TodoDataInitial());

  final todoRepository = TodoRepository();

  Future<void> readAll() async {
    emit(TodoDataInitial());

    try {
      var todos = await todoRepository.readAll();

      emit(TodoDataLoaded(
        todos: todos,
      ));
    } catch (e) {
      emit(TodoDataError(
        message: e.toString(),
      ));
    }
  }

  Future<void> create(Todo todo) async {
    emit(TodoDataInitial());

    try {
      await todoRepository.create(todo);

      // emit(TodoDataLoaded(
      //   todos: todos,
      // ));
    } catch (e) {
      emit(TodoDataError(
        message: e.toString(),
      ));
    }
  }
}
