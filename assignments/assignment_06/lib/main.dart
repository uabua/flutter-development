import 'package:assignment_06/logic/cubits/character_data/character_data_cubit.dart';
import 'package:assignment_06/logic/cubits/episode_data/episode_data_cubit.dart';
import 'package:assignment_06/presentation/router/app_router.dart';
import 'package:assignment_06/utils/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CharacterDataCubit>(
        create: (context) => CharacterDataCubit(),
      ),
      BlocProvider<EpisodeDataCubit>(
        create: (context) => EpisodeDataCubit(),
      )
    ],
    child: MaterialApp(
      theme: ThemeData.dark(),
      title: 'Rick & Morty',
      onGenerateRoute: AppRouter().onGenerateRoute,
    ),
  ));
}
