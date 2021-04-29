import 'package:flutter/foundation.dart';

class Car {
  final int id;
  final String brand;
  final String model;
  final String imageUrl;
  final int year;
  final String description;

  Car({
    @required this.id,
    @required this.brand,
    @required this.model,
    @required this.year,
    @required this.description,
    @required this.imageUrl,
  });
}
