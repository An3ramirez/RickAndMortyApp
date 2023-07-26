import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_app_bar.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_drawer_menu.dart';
import 'package:rick_and_morty_app/src/ui/pages/home/character_list.dart';
import 'package:rick_and_morty_app/src/ui/pages/home/character_state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;
  @override
  void initState() {
    super.initState();
    final apiProvider = ref.read(characterStateProvider.notifier);
    apiProvider.getCharacters(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        await apiProvider.getCharacters(page);
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
    final characterProvider = ref.watch(characterStateProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Personajes'),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: characterProvider.characters.isNotEmpty
            ? CharacterList(
                apiProvider: characterProvider,
                isLoading: isLoading,
                scrollController: scrollController,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      drawer: const CustomDrawerMenu(),
    );
  }
}
