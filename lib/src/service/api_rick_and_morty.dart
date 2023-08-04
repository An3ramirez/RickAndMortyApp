import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/src/models/episode_model.dart';
import 'package:rick_and_morty_app/src/models/location_model.dart';
import 'package:rick_and_morty_app/src/models/reponse_model.dart';

class ApiRickAndMorty {
  final url = 'rickandmortyapi.com';

  Future<Response<CharacterResponse>> getCharacters(int page,
      {Map<String, String> filters = const {}}) async {
    final result = await http.get(Uri.https(url, "/api/character", {
      'page': page.toString(),
      ...filters,
    }));

    var response = Response<CharacterResponse>(statusCode: result.statusCode);

    if (result.statusCode == 200) {
      response.body = characterResponseFromJson(result.body);
    } else {
      response.error = jsonDecode(result.body)['error'];
    }

    return response;
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

  Future<List<Episode>> getEpisodes(int page) async {
    List<Episode> episodes = [];

    final result = await http.get(Uri.https(url, 'api/episode/', {
      'page': page.toString(),
    }));

    final response = episodeResponseFromJson(result.body);
    episodes.addAll(response.results!);

    return episodes;
  }
}

final apiProvider = Provider(
  (ref) => ApiRickAndMorty(),
);
