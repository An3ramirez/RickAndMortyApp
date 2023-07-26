import 'package:rick_and_morty_app/src/models/character_model.dart';

class CharacterStatus {
  final List<Character> characters;
  final bool hasMoreItems;

  CharacterStatus({this.characters = const [], this.hasMoreItems = true});

  CharacterStatus copyWith({
    List<Character>? characters,
    bool? hasMoreItems,
  }) =>
      CharacterStatus(
        characters: characters ?? this.characters,
        hasMoreItems: hasMoreItems ?? this.hasMoreItems,
      );
}
