import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/entities/episodes_status.dart';
import 'package:rick_and_morty_app/src/service/api_rick_and_morty.dart';

class EpisodeNotifier extends StateNotifier<EpisodesStatus> {
  final ApiRickAndMorty _apiProvider;

  EpisodeNotifier(this._apiProvider) : super(EpisodesStatus());

  Future<void> getEpisodes(int page) async {
    var episodes = await _apiProvider.getEpisodes(page);
    var hasMoreItems = episodes.length < 20;
    // Combinar las ubicaciones anteriores con las nuevas
    var combinedEpisodes = [...state.episodes, ...episodes];
    state =
        state.copyWith(episodes: combinedEpisodes, hasMoreItems: !hasMoreItems);
  }
}

final StateNotifierProvider<EpisodeNotifier, EpisodesStatus>
    episodeStateProvider = StateNotifierProvider((ref) {
  var apiService = ref.watch(apiProvider);
  return EpisodeNotifier(apiService);
});
