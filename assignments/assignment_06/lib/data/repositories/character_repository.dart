import 'package:assignment_06/data/models/character.dart';
import 'package:dio/dio.dart';

class CharacterRepository {
  List<Character>? characters = [];
  Dio dio = Dio();

  Future<List<Character>>? fetchCharacters({int page = 1}) async {
    final response = await dio.get(
      'https://rickandmortyapi.com/api/character?page=$page',
    );

    if (response.statusCode == 200) {
      List<Character> loadedCharacters = [];

      response.data['results'].forEach((character) {
        var characterModel = Character.fromJson(character);
        loadedCharacters.add(characterModel);
        characters = loadedCharacters;

        return characters!;
      });
    }

    return characters!;
  }
}
