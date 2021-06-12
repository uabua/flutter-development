import 'package:flutter/material.dart';
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
    } else {
      return null;
    }
  }
}
