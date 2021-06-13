import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/data/models/todo.dart';
import 'package:midterm_02/logic/cubit/todo_data/todo_data_cubit.dart';

class AddTodo extends StatefulWidget {
  static const routeName = "/todos/add";

  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController topic = TextEditingController();
  final TextEditingController task = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void dispose() {
    topic.dispose();
    task.dispose();
    description.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
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
                    controller: topic,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please enter Topic',
                      labelText: 'Topic',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid Topic!';
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: task,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please enter Task',
                      labelText: 'Task',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid Task!';
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: description,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please enter Desciption',
                      labelText: 'Desciption',
                    ),
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
                            BlocProvider.of<TodoDataCubit>(context).create(
                              Todo(
                                topic: topic.text,
                                task: task.text,
                                description: description.text,
                              ),
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
