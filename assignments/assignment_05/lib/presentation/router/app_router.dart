import 'package:assignment_05/presentation/screens/todo.dart';
import 'package:assignment_05/presentation/screens/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (_) => const Home(),
      );
    } else if (settings.name == '/todo') {
      var userID = settings.arguments as String;

      return MaterialPageRoute(
        builder: (_) => Todo(
          userID: userID,
        ),
      );
    } else {
      return null;
    }
  }
}
