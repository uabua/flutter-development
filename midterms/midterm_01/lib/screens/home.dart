import 'package:flutter/material.dart';
import 'package:midterm_01/data/cars.dart';
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
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          var car = cars[index];
          return CarItem(
            imageUrl: car.imageUrl,
            name: "${car.brand} ${car.model}",
            year: car.year,
          );
        },
      ),
    );
  }
}
