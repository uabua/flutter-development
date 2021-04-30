import 'package:flutter/material.dart';

class CarItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int year;

  CarItem({
    required this.imageUrl,
    required this.name,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FadeInImage(
                placeholder: AssetImage(
                  "assets/placeholders/car_placeholder.webp",
                ),
                image: NetworkImage(
                  imageUrl,
                ),
                width: 300,
                height: 200,
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              "$year",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
