import 'package:flutter/material.dart';
import 'package:midterm_01/screens/add_car.dart';
import 'package:midterm_01/screens/car_details.dart';
import 'package:midterm_01/screens/edit_car.dart';
import 'package:midterm_01/screens/home.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    routes: {
      CarDetails.routeName: (context) => CarDetails(),
      EditCar.routeName: (context) => EditCar(),
      AddCar.routeName: (context) => AddCar(),
    },
  ));
}
