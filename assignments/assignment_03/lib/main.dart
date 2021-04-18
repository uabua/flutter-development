import 'package:assignment_03/planet.dart';
import 'package:assignment_03/planets.dart';
import 'package:flutter/material.dart';

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

  List<Widget> getButtons() {
    return List.generate(
      widget.planets.length,
      (index) => SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: OutlinedButton(
          onPressed: () => setState(() => planet = widget.planets[index]),
          child: Text(widget.planets[index].name),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 500) {
          return PlanetsPortrait(
            planet: planet,
            buttons: getButtons(),
          );
        } else {
          return PlanetsLandscape(
            planet: planet,
            buttons: getButtons(),
          );
        }
      },
    );
  }
}

class PlanetsPortrait extends StatelessWidget {
  final Planet planet;
  final List<Widget> buttons;

  PlanetsPortrait({this.planet, this.buttons});

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
          children: buttons,
        ),
      ],
    );
  }
}

class PlanetsLandscape extends StatelessWidget {
  final Planet planet;
  final List<Widget> buttons;

  PlanetsLandscape({
    this.planet,
    this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.network(
                  planet.url,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                planet.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          Column(
            children: buttons,
          ),
        ],
      ),
    );
  }
}
