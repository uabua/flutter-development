import 'package:flutter/material.dart';
import 'package:midterm_02/data/models/todo.dart';
import 'package:midterm_02/presentation/screens/add_todo.dart';
import 'package:midterm_02/presentation/screens/edit_todo.dart';
import 'package:midterm_02/presentation/screens/login.dart';
import 'package:midterm_02/presentation/screens/todos.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (_) => const Login(),
      );
    } else if (settings.name == Todos.routeName) {
      return MaterialPageRoute(
        builder: (_) => const Todos(),
      );
    } else if (settings.name == AddTodo.routeName) {
      return MaterialPageRoute(
        builder: (_) => const AddTodo(),
      );
    } else if (settings.name == EditTodo.routeName) {
      Todo todo = settings.arguments as Todo;

      return MaterialPageRoute(
        builder: (_) => EditTodo(
          todo: todo,
        ),
      );
    } else {
      return null;
    }
  }
}
