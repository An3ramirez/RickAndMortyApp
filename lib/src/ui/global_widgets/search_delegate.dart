import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/models/character_mode.dart';
import 'package:rick_and_morty_app/src/routes/routes.dart';
import 'package:rick_and_morty_app/src/ui/pages/home/character_state.dart';

class SearchCharacter extends SearchDelegate {
  final WidgetRef ref;

  SearchCharacter(this.ref);

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final characterProvider = ref.read(characterStateProvider.notifier);

    Widget widgetLoading() {
      return const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage:
              AssetImage('assets/images/portal-rick-and-morty.gif'),
        ),
      );
    }

    if (query.isEmpty) {
      return widgetLoading();
    }

    return FutureBuilder(
      future: characterProvider.getCharacter(query),
      builder: (context, AsyncSnapshot<List<Character>> snapshot) {
        if (!snapshot.hasData) {
          return widgetLoading();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final character = snapshot.data![index];
            return ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.CHARACTER_DETAIL,
                  arguments: character,
                );
              },
              title: Text(character.name!),
              leading: Hero(
                  tag: character.id!,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(character.image!),
                  )),
            );
          },
        );
      },
    );
  }
}
