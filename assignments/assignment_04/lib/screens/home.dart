import 'package:assignment_04/data/models/movie.dart';
import 'package:assignment_04/data/repositories/movie_repository.dart';
import 'package:assignment_04/screens/add_movie.dart';
import 'package:assignment_04/screens/edit_movie.dart';
import 'package:assignment_04/screens/movie_details.dart';
import 'package:assignment_04/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Icon(
                Icons.category,
                color: Colors.white,
                size: 70,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("All Movies"),
              leading: Icon(
                Icons.movie,
                color: Colors.black,
              ),
              onTap: () {
                Provider.of<MovieRepository>(
                  context,
                  listen: false,
                ).getAllMovies();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Recently Added"),
              leading: Icon(
                Icons.folder,
                color: Colors.black,
              ),
              onTap: () {
                Provider.of<MovieRepository>(
                  context,
                  listen: false,
                ).getRecentlyAdded();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("My Favorites"),
              leading: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              onTap: () {
                Provider.of<MovieRepository>(
                  context,
                  listen: false,
                ).getMyFavorites();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Consumer<MovieRepository>(
        builder: (context, value, child) {
          List<Movie> movies = Provider.of<MovieRepository>(context).movies;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];

              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                confirmDismiss: (direction) => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Delete Confirmation"),
                    content: Text(
                      "Are you sure you want to permanently delete this movie record?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<MovieRepository>(
                            context,
                            listen: false,
                          ).removeMovie(index);
                          Navigator.pop(context);
                        },
                        child: Text("Delete"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    MovieDetails.routeName,
                    arguments: index,
                  ),
                  onLongPress: () => Navigator.pushNamed(
                    context,
                    EditMovie.routeName,
                    arguments: index,
                  ),
                  child: MovieItem(
                    imageUrl: movie.imageUrl,
                    name: movie.name,
                    releaseDate: movie.releaseDate,
                    rating: movie.rating,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          AddMovie.routeName,
        ),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
