import 'package:flutter/material.dart';
import 'package:midterm_01/data/models/car.dart';
import 'package:midterm_01/data/repository/car_helper.dart';

class AddCar extends StatelessWidget {
  static const routeName = "/add";

  final TextEditingController brand = TextEditingController();
  final TextEditingController year = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController imageUrl = TextEditingController();
  final TextEditingController model = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    initialValue: "${CarHelper().getNewId()}",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "ID",
                    ),
                    enabled: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: brand,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Brand",
                      labelText: "Brand",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Brand!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: model,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Model",
                      labelText: "Model",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Model!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: year,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Year",
                      labelText: "Year",
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null ||
                          int.parse(value) <= 0) {
                        return "Please enter valid Year!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: description,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Description",
                      labelText: "Description",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Description!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: imageUrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Image URL",
                      labelText: "Image URL",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Image URL!";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Back"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Car car = Car(
                              id: CarHelper().getNewId(),
                              brand: brand.text,
                              model: model.text,
                              year: int.parse(year.text),
                              description: description.text,
                              imageUrl: imageUrl.text,
                            );
                            CarHelper().addCar(car);
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Add"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
