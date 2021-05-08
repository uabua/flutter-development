import 'package:assignment_04/data/models/movie.dart';
import 'package:assignment_04/data/repositories/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditMovie extends StatefulWidget {
  static const routeName = "/edit";

  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController releaseDate;
  late TextEditingController rating;
  late TextEditingController imageUrl;
  String? category;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final Movie movie = Provider.of<MovieRepository>(
      context,
      listen: false,
    ).movies[index];
    final int id = Provider.of<MovieRepository>(
      context,
      listen: false,
    ).getNewId();

    name = TextEditingController(
      text: movie.name,
    );
    description = TextEditingController(
      text: movie.description,
    );
    releaseDate = TextEditingController(
      text: "${movie.releaseDate}",
    );
    rating = TextEditingController(
      text: "${movie.rating}",
    );
    imageUrl = TextEditingController(
      text: movie.imageUrl,
    );

    if (category == null) {
      category = movie.category;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Movie"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    initialValue: "$id",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "ID",
                    ),
                    enabled: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Name",
                      labelText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Name!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: description,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Description",
                      labelText: "Description",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Description!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: releaseDate,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Release Date",
                      labelText: "Release Date",
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return "Please enter valid Release Date!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: rating,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Rating",
                      labelText: "Rating",
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null ||
                          double.parse(value) < 0 ||
                          double.parse(value) > 10) {
                        return "Please enter valid Rating!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: imageUrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Image URL",
                      labelText: "Image URL",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Image URL!";
                      }

                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.category,
                    ),
                    Container(
                      width: 250,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: category,
                        onChanged: (value) {
                          setState(() {
                            category = value!;
                          });
                        },
                        items: <String>[
                          "Recently Added",
                          "My Favorites",
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Back"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Movie editedMovie = Movie(
                              id: id,
                              name: name.text,
                              description: description.text,
                              releaseDate: int.parse(releaseDate.text),
                              rating: double.parse(rating.text),
                              category: category!,
                              imageUrl: imageUrl.text,
                            );
                            Provider.of<MovieRepository>(
                              context,
                              listen: false,
                            ).editMovie(index, editedMovie);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Edit"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
