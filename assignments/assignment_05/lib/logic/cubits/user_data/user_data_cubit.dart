import 'package:assignment_05/data/models/user.dart';
import 'package:assignment_05/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  final userRepository = UserRepository();

  Future<void> getUserData() async {
    try {
      var list = await userRepository.fetchUsers();
      emit(UserDataLoaded(users: list!));
    } catch (e) {
      emit(UserDataError(message: e.toString()));
    }
  }
}
