import 'package:assignment_05/data/models/todo.dart';
import 'package:dio/dio.dart';

class TodoRepository {
  List<Todo>? todos = [];
  Dio dio = Dio();

  Future<List<Todo>>? fetchTodoByUserID(String userID) async {
    var response = await dio
        .get('https://jsonplaceholder.typicode.com/users/$userID/todos');
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
