import 'package:assignment_05/data/models/todo.dart';
import 'package:assignment_05/data/repositories/todo_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_data_state.dart';

class TodoDataCubit extends Cubit<TodoDataState> {
  TodoDataCubit() : super(TodoDataInitial());

  final todoRepository = TodoRepository();

  Future<void> addTodoData(Map<String, dynamic> todoData) async {
    final todos = (state as TodoDataLoaded).todos;

    emit(TodoDataInitial());

    try {
      await todoRepository.addTodoData(todoData);

      final todo = Todo(
        id: todos.last.id! + 1,
        userId: todoData['userId'],
        title: todoData['title'],
        completed: false,
      );

      todos.insert(0, todo);

      emit(TodoDataLoaded(
        todos: todos,
      ));
    } catch (e) {
      emit(TodoDataError(
        message: e.toString(),
      ));
    }
  }

  Future<void> deleteTodoData(int todoId) async {
    final todos = (state as TodoDataLoaded).todos;

    emit(TodoDataInitial());

    try {
      await todoRepository.deleteTodoData(todoId);

      todos.removeWhere((todo) => todo.id == todoId);

      emit(TodoDataLoaded(
        todos: todos,
      ));
    } catch (e) {
      emit(TodoDataError(
        message: e.toString(),
      ));
    }
  }

  Future<void> getTodoData(String userId) async {
    emit(TodoDataInitial());

    try {
      var list = await todoRepository.fetchTodoByUserID(userId);
      emit(TodoDataLoaded(
        todos: list!,
      ));
    } catch (e) {
      emit(TodoDataError(
        message: e.toString(),
      ));
    }
  }
}
