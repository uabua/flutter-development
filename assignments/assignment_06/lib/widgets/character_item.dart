import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final String image;
  final String name;
  final String status;

  const CharacterItem({
    Key? key,
    required this.image,
    required this.name,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(150.0),
              child: FadeInImage(
                placeholder: const AssetImage(
                  'assets/placeholders/placeholder.png',
                ),
                image: NetworkImage(
                  image,
                ),
                width: 150,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getStatusIcon(status),
                Text(
                  status,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Icon _getStatusIcon(String status) {
    if (status == 'Alive') {
      return const Icon(
        Icons.favorite,
        color: Colors.red,
      );
    } else if (status == 'Dead') {
      return const Icon(
        Icons.cancel,
        color: Colors.black,
      );
    } else {
      return const Icon(
        Icons.help_outline,
        color: Colors.grey,
      );
    }
  }
}
