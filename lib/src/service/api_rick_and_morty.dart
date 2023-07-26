import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/src/models/episode_model.dart';
import 'package:rick_and_morty_app/src/models/location_model.dart';

class ApiRickAndMorty {
  final url = 'rickandmortyapi.com';

  List<Episode> episodes = [];

  Future<List<Character>> getCharacters(int page) async {
    List<Character> characters = [];
    final result = await http.get(Uri.https(url, "/api/character", {
      'page': page.toString(),
    }));
    final response = characterResponseFromJson(result.body);

    characters.addAll(response.results!);
    return characters;
  }

  Future<List<Location>> getLocations(int page) async {
    List<Location> locations = [];
    final result = await http.get(Uri.https(url, "/api/location", {
      'page': page.toString(),
    }));
    final response = locationResponseFromJson(result.body);

    locations.addAll(response.results!);
    return locations;
  }

  Future<List<Character>> getCharacter(String name) async {
    final result =
        await http.get(Uri.https(url, '/api/character/', {'name': name}));
    final response = characterResponseFromJson(result.body);
    return response.results!;
  }

  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = [];
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
    }
    return episodes;
  }
}

final apiProvider = Provider(
  (ref) => ApiRickAndMorty(),
);
