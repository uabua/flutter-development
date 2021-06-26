import 'package:final_project/presentation/screens/login.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (_) => const Login(),
      );
      // } else if (settings.name == Todos.routeName) {
      //   String userId = settings.arguments as String;

      //   return MaterialPageRoute(
      //     builder: (_) => Todos(
      //       userId: userId,
      //     ),
      //   );
      // } else if (settings.name == AddTodo.routeName) {
      //   return MaterialPageRoute(
      //     builder: (_) => const AddTodo(),
      //   );
      // } else if (settings.name == EditTodo.routeName) {
      //   Todo todo = settings.arguments as Todo;

      //   return MaterialPageRoute(
      //     builder: (_) => EditTodo(
      //       todo: todo,
      //     ),
      //   );
    } else {
      return null;
    }
  }
}
