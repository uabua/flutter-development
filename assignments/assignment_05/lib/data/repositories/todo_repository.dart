import 'package:assignment_05/data/models/todo.dart';
import 'package:dio/dio.dart';

class TodoRepository {
  List<Todo>? todos = [];
  Dio dio = Dio();

  Future<void> addTodoData(Map<String, dynamic> todoData) async =>
      await dio.post(
        // substitute URL for the target endpoint
        'https://jsonplaceholder.typicode.com/posts',
        data: {
          'userId': todoData['userId'],
          'title': todoData['title'],
        },
      );

  Future<void> deleteTodoData(int todoId) async => await dio.delete(
        // substitute URL for the target endpoint
        'https://jsonplaceholder.typicode.com/posts/$todoId',
      );

  Future<List<Todo>>? fetchTodoByUserID(String userId) async {
    var response = await dio
        .get('https://jsonplaceholder.typicode.com/users/$userId/todos');
    if (response.statusCode == 200) {
      List<Todo> loadedTodos = [];

      response.data.forEach((todo) {
        var todoModel = Todo.fromJson(todo);
        loadedTodos.add(todoModel);
        todos = loadedTodos;

        return todos!;
      });
    }

    return todos!;
  }
}
