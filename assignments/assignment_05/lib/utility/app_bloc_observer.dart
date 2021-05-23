import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('${bloc.runtimeType} $event');

    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    print('${bloc.runtimeType} $error $stacktrace');

    super.onError(bloc, error, stacktrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');

    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');

    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    print('${bloc.runtimeType}');

    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print('${bloc.runtimeType}');

    super.onClose(bloc);
  }
}
