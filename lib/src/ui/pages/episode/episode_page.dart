import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_app_bar.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_drawer_menu.dart';
import 'package:rick_and_morty_app/src/ui/pages/episode/episode_list.dart';
import 'package:rick_and_morty_app/src/ui/pages/episode/episode_state.dart';

class EpisodePage extends ConsumerStatefulWidget {
  const EpisodePage({super.key});

  @override
  EpisodePageState createState() => EpisodePageState();
}

class EpisodePageState extends ConsumerState<EpisodePage> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final apiProvider = ref.read(episodeStateProvider.notifier);
    apiProvider.getEpisodes(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        await apiProvider.getEpisodes(page);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final episodeProvider = ref.watch(episodeStateProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Episodios'),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: episodeProvider.episodes.isNotEmpty
            ? EpisodeList(
                scrollController: scrollController,
                isLoading: isLoading,
                episodeProvider: episodeProvider,
              )
            : const Center(child: CircularProgressIndicator()),
      ),
      drawer: const CustomDrawerMenu(),
    );
  }
}
