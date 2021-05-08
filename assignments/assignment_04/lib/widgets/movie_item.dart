import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int releaseDate;
  final double rating;

  MovieItem({
    required this.imageUrl,
    required this.name,
    required this.releaseDate,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 5.0,
              ),
              child: FadeInImage(
                placeholder: AssetImage(
                  "assets/placeholders/movie_placeholder.png",
                ),
                image: NetworkImage(
                  imageUrl,
                ),
                width: 400,
                height: 400,
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              "$releaseDate",
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              "⭐ $rating",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
