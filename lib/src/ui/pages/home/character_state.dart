import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/entities/character_status.dart';
import 'package:rick_and_morty_app/src/models/character_model.dart';
import 'package:rick_and_morty_app/src/service/api_rick_and_morty.dart';

class CharacterNotifier extends StateNotifier<CharacterStatus> {
  final ApiRickAndMorty _apiProvider;

  CharacterNotifier(this._apiProvider) : super(CharacterStatus());

  Future<void> getCharacters(int page) async {
    var characters = await _apiProvider.getCharacters(page);
    var hasMoreItems = characters.length < 20;
    // Combinar los personajes anteriores con los nuevos
    var combinedCharacters = [...state.characters, ...characters];
    state = state.copyWith(
      characters: combinedCharacters,
      hasMoreItems: !hasMoreItems,
    );
  }

  Future<List<Character>> getCharacter(String name) async {
    var charater = await _apiProvider.getCharacter(name);
    return charater;
  }
}

final StateNotifierProvider<CharacterNotifier, CharacterStatus>
    characterStateProvider = StateNotifierProvider((ref) {
  var apiService = ref.watch(apiProvider);
  return CharacterNotifier(apiService);
});
