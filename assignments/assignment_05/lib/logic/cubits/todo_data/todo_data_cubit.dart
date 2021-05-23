import 'package:assignment_05/data/models/todo.dart';
import 'package:assignment_05/data/repositories/todo_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_data_state.dart';

class TodoDataCubit extends Cubit<TodoDataState> {
  TodoDataCubit() : super(TodoDataInitial());

  final todoRepository = TodoRepository();

  Future<void> getTodoData(String userID) async {
    emit(TodoDataInitial());

    try {
      var list = await todoRepository.fetchTodoByUserID(userID);
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
