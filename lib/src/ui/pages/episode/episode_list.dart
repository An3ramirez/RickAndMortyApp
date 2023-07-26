import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/entities/episodes_status.dart';
import 'package:rick_and_morty_app/src/routes/routes.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    super.key,
    required this.episodeProvider,
    required this.scrollController,
    required this.isLoading,
  });

  final EpisodesStatus episodeProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: isLoading
          ? episodeProvider.episodes.length + 1
          : episodeProvider.episodes.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < episodeProvider.episodes.length) {
          final episode = episodeProvider.episodes[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.EPISODE_DETAIL,
                  arguments: episode);
            },
            child: ListTile(
              title: Text('${index + 1} - ${episode.name}'),
              subtitle: Text('Numero: ${episode.episode}'),
            ),
          );
        } else {
          return Center(
            child: episodeProvider.hasMoreItems
                ? const CircularProgressIndicator()
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'No hay mas información',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
          );
        }
      },
    );
  }
}
