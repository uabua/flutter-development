import 'package:assignment_05/logic/cubits/todo_data/todo_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodo extends StatefulWidget {
  static const routeName = "/todo/add";

  final String userId;

  const AddTodo({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
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
                    initialValue: widget.userId,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "User ID",
                    ),
                    enabled: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please enter Title",
                      labelText: "Title",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Title!";
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
                        child: const Text("Back"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<TodoDataCubit>(context).addTodoData(
                              {
                                'userId': int.parse(widget.userId),
                                'title': titleController.text,
                              },
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Add"),
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
