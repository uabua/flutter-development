import 'package:assignment_04/data/models/movie.dart';
import 'package:assignment_04/data/repositories/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatelessWidget {
  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final Movie movie = Provider.of<MovieRepository>(
      context,
      listen: false,
    ).movies[index];

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FadeInImage(
                placeholder: AssetImage(
                  "assets/placeholders/movie_placeholder.png",
                ),
                image: NetworkImage(
                  movie.imageUrl,
                ),
                width: 400,
                height: 400,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          movie.category == "My Favorites"
                              ? Icons.favorite
                              : Icons.folder,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "${movie.name} (${movie.releaseDate})",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "⭐ ${movie.rating}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                movie.description,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
