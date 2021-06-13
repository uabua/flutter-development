import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/data/repositories/todo_repository.dart';
import 'package:midterm_02/logic/cubit/todo_data/todo_data_cubit.dart';
import 'package:midterm_02/presentation/screens/add_todo.dart';
import 'package:midterm_02/presentation/screens/edit_todo.dart';

class Todos extends StatelessWidget {
  static const routeName = '/todos';
  const Todos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: true,
      ),
      body: BlocConsumer<TodoDataCubit, TodoDataState>(
        builder: (context, state) {
          if (state is TodoDataInitial) {
            BlocProvider.of<TodoDataCubit>(context).readAll();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoDataLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                var todo = state.todos[index];

                return Dismissible(
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Delete Confirmation'),
                      content: Text(
                        'Are you sure you want to permanently delete this task?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<TodoDataCubit>(context).delete(
                              todo.id,
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text(
                            //         'Successfully removed "${todo.task}"!'),
                            //     backgroundColor: Colors.green,
                            //   ),
                            // );

                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    title: Text(todo.topic),
                    onLongPress: () => Navigator.pushNamed(
                      context,
                      EditTodo.routeName,
                      arguments: todo,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Oops! Something went wrong!'),
            );
          }
        },
        listener: (context, state) {
          if (state is TodoDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddTodo.routeName,
          );
        },
      ),
    );
  }
}
