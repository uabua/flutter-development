import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/logic/cubit/todo_data/todo_data_cubit.dart';
import 'package:midterm_02/presentation/screens/add_todo.dart';
import 'package:midterm_02/presentation/screens/edit_todo.dart';
import 'package:midterm_02/widgets/todo_item.dart';

class Todos extends StatelessWidget {
  static const routeName = '/todos';
  final String userId;

  const Todos({
    Key? key,
    required this.userId,
  }) : super(key: key);

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
            BlocProvider.of<TodoDataCubit>(context).todoRepository.userId =
                userId;

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
                      title: const Text('Delete Confirmation'),
                      content: const Text(
                        'Are you sure you want to permanently delete this task?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<TodoDataCubit>(context).delete(
                              todo.id,
                            );

                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
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
                  child: GestureDetector(
                    onLongPress: () => Navigator.pushNamed(
                      context,
                      EditTodo.routeName,
                      arguments: todo,
                    ),
                    onDoubleTap: () => BlocProvider.of<TodoDataCubit>(context)
                        .toggleCompletion(todo.id, todo.isCompleted),
                    child: TodoItem(
                      topic: todo.topic,
                      task: todo.task,
                      description: todo.description,
                      isCompleted: todo.isCompleted,
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
                backgroundColor: Colors.red,
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
