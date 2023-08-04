import 'package:rick_and_morty_app/src/models/character_model.dart';

class CharacterStatus {
  final List<Character> characters;
  final bool hasMoreItems;
  final bool loader;
  final String error;

  CharacterStatus({
    this.characters = const [],
    this.hasMoreItems = true,
    this.loader = true,
    this.error = '',
  });

  CharacterStatus copyWith({
    List<Character>? characters,
    bool? hasMoreItems,
    bool? loader,
    String? error,
  }) =>
      CharacterStatus(
        characters: characters ?? this.characters,
        hasMoreItems: hasMoreItems ?? this.hasMoreItems,
        loader: loader ?? this.loader,
        error: error ?? this.error,
      );
}
