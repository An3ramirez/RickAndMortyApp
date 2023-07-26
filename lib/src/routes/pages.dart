// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';

import 'package:rick_and_morty_app/src/routes/routes.dart';

/** Pages */
import 'package:rick_and_morty_app/src/ui/pages/home/home_page.dart';
import 'package:rick_and_morty_app/src/ui/pages/home/character_detail_page.dart';
import 'package:rick_and_morty_app/src/ui/pages/location/location_detail_page.dart';
import 'package:rick_and_morty_app/src/ui/pages/location/location_page.dart';
import 'package:rick_and_morty_app/src/ui/pages/episode/episode_detail_page.dart';
import 'package:rick_and_morty_app/src/ui/pages/episode/episode_page.dart';

abstract class Pages {
  static const String INITIAL = Routes.HOME;
  static const String HOME = Routes.HOME;

  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.HOME: (_) => const HomePage(),
    Routes.CHARACTER_DETAIL: (_) => const CharacterDetailPage(),
    Routes.LOCATION: (_) => const LocationPage(),
    Routes.LOCATION_DETAIL: (_) => const LocationDetailPage(),
    Routes.EPISODE: (_) => const EpisodePage(),
    Routes.EPISODE_DETAIL: (_) => const EpisodeDetailPage(),
  };
}
