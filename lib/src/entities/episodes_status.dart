import '../models/episode_model.dart';

class EpisodesStatus {
  final List<Episode> episodes;

  EpisodesStatus({this.episodes = const []});

  EpisodesStatus copyWith({List<Episode>? episodes}) =>
      EpisodesStatus(episodes: episodes ?? this.episodes);
}
