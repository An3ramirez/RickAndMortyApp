import 'dart:convert';

import 'package:rick_and_morty_app/src/models/info_model.dart';

CharacterResponse characterResponseFromJson(String str) =>
    CharacterResponse.fromJson(json.decode(str));

String characterResponseToJson(CharacterResponse data) =>
    json.encode(data.toJson());

class CharacterResponse {
  Info? info;
  List<Character>? results;

  CharacterResponse({
    this.info,
    this.results,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      CharacterResponse(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<Character>.from(
                json["results"]!.map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Character {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  LocationSub? origin;
  LocationSub? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  Character({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: json["origin"] == null
            ? null
            : LocationSub.fromJson(json["origin"]),
        location: json["location"] == null
            ? null
            : LocationSub.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null
            ? []
            : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode":
            episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}

class LocationSub {
  String? name;
  String? url;

  LocationSub({
    this.name,
    this.url,
  });

  factory LocationSub.fromJson(Map<String, dynamic> json) => LocationSub(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
