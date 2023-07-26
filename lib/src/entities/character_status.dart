import 'package:rick_and_morty_app/src/models/character_mode.dart';
import 'package:rick_and_morty_app/src/models/episode_model.dart';

class CharacterStatus {
  final List<Character> characters;
  final List<Episode> episodes;

  CharacterStatus({this.characters = const [], this.episodes = const []});

  CharacterStatus copyWith({
    List<Character>? characters,
    List<Episode>? episodes,
  }) =>
      CharacterStatus(
        characters: characters ?? this.characters,
        episodes: episodes ?? this.episodes,
      );
}
