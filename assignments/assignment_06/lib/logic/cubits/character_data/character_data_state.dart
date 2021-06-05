part of 'character_data_cubit.dart';

abstract class CharacterDataState extends Equatable {
  const CharacterDataState();
}

class CharacterDataInitial extends CharacterDataState {
  @override
  List<Object> get props => [];
}

class CharacterDataLoaded extends CharacterDataState {
  final List<Character> characters;

  const CharacterDataLoaded({
    required this.characters,
  });

  @override
  List<Object?> get props => [characters];
}

class CharacterDataError extends CharacterDataState {
  final String message;

  const CharacterDataError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
