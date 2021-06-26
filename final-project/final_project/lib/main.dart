import 'package:final_project/logic/cubit/expense_data/expense_data_cubit.dart';
import 'package:final_project/presentation/router/app_router.dart';
import 'package:final_project/utils/app_bloc_observer.dart';
import 'package:final_project/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ExpenseDataCubit>(
          create: (context) => ExpenseDataCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Personal Expenses App',
        onGenerateRoute: AppRouter().onGenerateRoute,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: backgroundColor,
        ),
      ),
    ),
  );
}
