import '../models/episode_model.dart';

class EpisodesStatus {
  final List<Episode> episodes;
  final bool hasMoreItems;

  EpisodesStatus({this.episodes = const [], this.hasMoreItems = true});

  EpisodesStatus copyWith({
    List<Episode>? episodes,
    bool? hasMoreItems,
  }) =>
      EpisodesStatus(
        episodes: episodes ?? this.episodes,
        hasMoreItems: hasMoreItems ?? this.hasMoreItems,
      );
}
