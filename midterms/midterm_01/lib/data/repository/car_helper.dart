import 'package:midterm_01/data/cars.dart';
import 'package:midterm_01/data/models/car.dart';

class CarHelper {
  void addCar(Car car) {
    cars.add(car);
  }

  void removeCar(int index) {
    cars.removeAt(index);
  }

  void editCar(int index, Car car) {
    cars[index] = car;
  }

  int getNewId() {
    if (cars.isNotEmpty) {
      return cars.last.id + 1;
    }

    return 1;
  }
}
