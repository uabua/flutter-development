import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midterm_02/logic/cubit/todo_data/todo_data_cubit.dart';
import 'package:midterm_02/presentation/router/app_router.dart';
import 'package:midterm_02/utils/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TodoDataCubit>(
        create: (context) => TodoDataCubit(),
      ),
    ],
    child: MaterialApp(
      title: 'Todo App',
      onGenerateRoute: AppRouter().onGenerateRoute,
    ),
  ));
}
