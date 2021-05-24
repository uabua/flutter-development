import 'package:assignment_05/logic/cubits/todo_data/todo_data_cubit.dart';
import 'package:assignment_05/presentation/screens/add_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Todo extends StatelessWidget {
  const Todo({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;

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

                return Dismissible(
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    BlocProvider.of<TodoDataCubit>(context).deleteTodoData(
                      todo.id!,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully removed "${todo.title}"!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddTodo.routeName,
            arguments: userId,
          );
        },
      ),
    );
  }
}
