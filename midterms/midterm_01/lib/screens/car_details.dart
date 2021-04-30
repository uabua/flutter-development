import 'package:flutter/material.dart';
import 'package:midterm_01/data/cars.dart';
import 'package:midterm_01/data/models/car.dart';
import 'package:midterm_01/data/repository/car_helper.dart';

class CarDetails extends StatelessWidget {
  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final Car car = cars[index];

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Delete Confirmation"),
                content: Text(
                  "Are you sure you want to permanently delete this car record?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      CarHelper().removeCar(index);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Delete"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FadeInImage(
                placeholder: AssetImage(
                  "assets/placeholders/car_placeholder.webp",
                ),
                image: NetworkImage(
                  car.imageUrl,
                ),
                width: 350,
                height: 250,
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Brand:",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            "Model: ",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            "Year: ",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(car.brand),
                          Text(car.model),
                          Text("${car.year}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 350,
                child: Text(
                  car.description,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
