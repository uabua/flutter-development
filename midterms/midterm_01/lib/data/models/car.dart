// import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
// დავტოვო რომელიც სჯობს

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
