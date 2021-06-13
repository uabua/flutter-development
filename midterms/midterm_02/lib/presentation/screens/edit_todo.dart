import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/data/models/todo.dart';
import 'package:midterm_02/logic/cubit/todo_data/todo_data_cubit.dart';

class EditTodo extends StatefulWidget {
  static const routeName = '/edit';
  final Todo todo;

  const EditTodo({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController topic;
  late TextEditingController task;
  late TextEditingController description;

  @override
  void dispose() {
    topic.dispose();
    task.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    topic = TextEditingController(
      text: widget.todo.topic,
    );

    task = TextEditingController(
      text: widget.todo.task,
    );

    description = TextEditingController(
      text: widget.todo.description,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/icons/rocket.png'),
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: topic,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please enter Topic',
                      prefixIcon: Icon(
                        Icons.topic,
                      ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: task,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please enter Task',
                      prefixIcon: Icon(
                        Icons.task,
                      ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: description,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please enter Desciption',
                      prefixIcon: Icon(
                        Icons.description,
                      ),
                    ),
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Back'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<TodoDataCubit>(context).update(
                              widget.todo.id,
                              Todo(
                                topic: topic.text,
                                task: task.text,
                                description: description.text,
                                isCompleted: widget.todo.isCompleted,
                              ),
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Edit'),
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
