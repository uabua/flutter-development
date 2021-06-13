import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/logic/cubit/todo_data/todo_data_cubit.dart';
import 'package:midterm_02/presentation/screens/todos.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userId = TextEditingController();

  @override
  void dispose() {
    userId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('assets/icons/check.png'),
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Todo App✨',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: userId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter UserID',
                    prefixIcon: Icon(
                      Icons.account_circle,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid UserID!';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(
                        context,
                        Todos.routeName,
                        arguments: userId.text,
                      );

                      BlocProvider.of<TodoDataCubit>(context)
                          .emit(TodoDataInitial());
                    }
                  },
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
