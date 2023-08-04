import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/entities/character_status.dart';
import 'package:rick_and_morty_app/src/models/character_model.dart';
import 'package:rick_and_morty_app/src/service/api_rick_and_morty.dart';

class CharacterNotifier extends StateNotifier<CharacterStatus> {
  final ApiRickAndMorty _apiProvider;
  Map<String, String> characterFilterPrevius = {};

  CharacterNotifier(this._apiProvider) : super(CharacterStatus());

  Future<void> getCharacters(int page,
      {String? stateFilter, String? genderFilter}) async {
    var filters = {
      'status': stateFilter == 'All' ? '' : stateFilter ?? '',
      'gender': genderFilter == 'All' ? '' : genderFilter ?? '',
    };
    bool hasMoreItems = true;
    if (!mapEquals(filters, characterFilterPrevius) && !state.loader) {
      state = state.copyWith(loader: true);
    }
    var response = await _apiProvider.getCharacters(page, filters: filters);
    if (response.statusCode != 200) {
      state = state.copyWith(error: response.error, loader: false);
      return;
    }
    var characters = response.body?.results ?? [];
    var totalPages = response.body?.info?.pages ?? 0;
    hasMoreItems = page < totalPages;

    final combinedCharacters = mapEquals(filters, characterFilterPrevius)
        ? [...state.characters, ...characters]
        : characters;

    state = state.copyWith(
      characters: combinedCharacters,
      hasMoreItems: hasMoreItems,
      loader: false,
    );

    characterFilterPrevius = filters;
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
