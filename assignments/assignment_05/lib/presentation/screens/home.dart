import 'package:assignment_05/logic/cubits/user_data/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,
      ),
      body: BlocConsumer<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is UserDataInitial) {
            BlocProvider.of<UserDataCubit>(context).getUserData();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserDataLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                var user = state.users[index];
                return ListTile(
                  // onTap: () {
                  //   Navigator.of(context).pushNamed(
                  //     '/todo-screen',
                  //     arguments: user.id.toString(),
                  //   );
                  // },
                  title: Text(user.name!),
                  subtitle: Text(user.email!),
                  leading: const Icon(
                    Icons.account_circle,
                    size: 40,
                    color: Colors.blue,
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
          if (state is UserDataError) {
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
