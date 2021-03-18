import 'package:assignment_01/planet.dart';
import 'package:flutter/material.dart';

const planets = <Planet>[
  Planet(
    "Saturn",
    "https://cdn.images.express.co.uk/img/dynamic/151/590x/Saturn-at-night-how-to-see-Saturn-rings-astronomy-saturn-opposition-closest-Earth-1150859.webp",
  ),
  Planet(
    "Uranus",
    "https://spaceexploration.webnode.com/_files/200000055-c164bc2605/2-29.jpg",
  ),
  Planet(
    "Neptune",
    "https://www.innovationnewsnetwork.com/wp-content/uploads/2020/12/Neptune-696x392.jpg",
  ),
];

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Planets"),
          centerTitle: true,
        ),
        body: Planets(
          planets: planets,
        ),
      ),
    ),
  );
}

class Planets extends StatefulWidget {
  final List<Planet> planets;

  Planets({@required this.planets});

  @override
  _PlanetsState createState() => _PlanetsState();
}

class _PlanetsState extends State<Planets> {
  Planet planet;

  @override
  void initState() {
    planet = widget.planets.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          planet.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        Image.network(
          planet.url,
          width: 300,
          height: 200,
          fit: BoxFit.cover,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.planets.length,
            (index) => OutlinedButton(
              onPressed: () => setState(() => planet = widget.planets[index]),
              child: Text(widget.planets[index].name),
            ),
          ),
        ),
      ],
    );
  }
}
