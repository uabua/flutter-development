import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final String image;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String origin;
  final String location;

  const CharacterItem({
    Key? key,
    required this.image,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
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
                  "assets/placeholders/placeholder.png",
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
        // child: Row(
        //   children: [
        //     Expanded(
        //       flex: 1,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(150.0),
        //         child: FadeInImage(
        //           placeholder: const AssetImage(
        //             "assets/placeholders/placeholder.png",
        //           ),
        //           image: NetworkImage(
        //             image,
        //           ),
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 2,
        //       child: Column(
        //         children: [
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               _getStatusIcon(status),
        //               Text(
        //                 status,
        //                 style: Theme.of(context).textTheme.bodyText1,
        //               ),
        //             ],
        //           ),
        //           Text(
        //             name,
        //             style: const TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 20,
        //             ),
        //             textAlign: TextAlign.center,
        //           ),

        //           // Text(
        //           //   'aa ${species == '' ? 'N/A' : species}',
        //           //   style: Theme.of(context).textTheme.caption,
        //           // ),
        //           // Text(
        //           //   'type - ${type == '' ? 'N/A' : type}',
        //           //   style: Theme.of(context).textTheme.caption,
        //           // ),
        //           // Text(
        //           //   'gender - ${gender == '' ? 'N/A' : gender}',
        //           //   style: Theme.of(context).textTheme.caption,
        //           // ),
        //           // Text(
        //           //   'origin - ${origin == '' ? 'N/A' : origin}',
        //           //   style: Theme.of(context).textTheme.caption,
        //           // ),
        //           // Text(
        //           //   'last known location - ${location == '' ? 'N/A' : location}',
        //           //   style: Theme.of(context).textTheme.caption,
        //           // ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
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
