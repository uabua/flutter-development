import 'package:assignment_06/data/models/character.dart';
import 'package:assignment_06/data/repositories/character_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_data_state.dart';

class CharacterDataCubit extends Cubit<CharacterDataState> {
  CharacterDataCubit() : super(CharacterDataInitial());

  int page = 1;

  final characterRepository = CharacterRepository();

  Future<void> getCharacterData({int page = 1}) async {
    try {
      var characters = await characterRepository.fetchCharacters(page: page);

      emit(CharacterDataLoaded(
        characters: characters,
      ));
    } catch (e) {
      emit(CharacterDataError(
        message: e.toString(),
      ));
    }
  }
}
