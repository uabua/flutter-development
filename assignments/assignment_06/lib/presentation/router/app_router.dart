import 'package:assignment_06/presentation/screens/episodes.dart';
import 'package:assignment_06/presentation/screens/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (_) => const Home(),
      );
    } else if (settings.name == Episodes.routeName) {
      List<dynamic> episodes = settings.arguments as List<dynamic>;

      return MaterialPageRoute(
        builder: (_) => Episodes(
          episodes: [
            episodes,
          ],
        ),
      );
    } else {
      return null;
    }
  }
}
