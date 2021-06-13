import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String topic;
  final String task;
  final String description;
  final bool isCompleted;

  const TodoItem({
    Key? key,
    required this.topic,
    required this.task,
    required this.description,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String assetName = isCompleted
        ? 'assets/icons/rocket_launch_completed.png'
        : 'assets/icons/rocket_launch_not_completed.png';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image(
                image: AssetImage(assetName),
                height: 60,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        topic,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const Icon(
                        Icons.topic,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Text(
                    task,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
