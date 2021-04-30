import 'package:flutter/material.dart';
import 'package:midterm_01/data/cars.dart';
import 'package:midterm_01/screens/add_car.dart';
import 'package:midterm_01/screens/car_details.dart';
import 'package:midterm_01/screens/edit_car.dart';
import 'package:midterm_01/widgets/car_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cars"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(
              context,
              AddCar.routeName,
            ).then((_) => setState(() {})),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          var car = cars[index];

          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              CarDetails.routeName,
              arguments: index,
            ).then((_) => setState(() {})),
            onLongPress: () => Navigator.pushNamed(
              context,
              EditCar.routeName,
              arguments: index,
            ).then((_) => setState(() {})),
            child: CarItem(
              imageUrl: car.imageUrl,
              name: "${car.brand} ${car.model}",
              year: car.year,
            ),
          );
        },
      ),
    );
  }
}
