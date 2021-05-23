import 'package:assignment_05/logic/cubits/todo_data/todo_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Todo extends StatelessWidget {
  const Todo({Key? key, required this.userID}) : super(key: key);
  final String userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To do"),
        centerTitle: true,
      ),
      body: BlocConsumer<TodoDataCubit, TodoDataState>(
        builder: (context, state) {
          if (state is TodoDataInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoDataLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                var todo = state.todos[index];

                return ListTile(
                  title: Text(todo.title!),
                  trailing: todo.completed!
                      ? const Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Ops! Something went wrong!'),
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
    );
  }
}
