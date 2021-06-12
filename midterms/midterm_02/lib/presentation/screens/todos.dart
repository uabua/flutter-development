import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/logic/cubit/todo_data/todo_data_cubit.dart';

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
                return const ListTile(
                  title: Text('helppp'),
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
        onPressed: () {},
      ),
    );
  }
}
