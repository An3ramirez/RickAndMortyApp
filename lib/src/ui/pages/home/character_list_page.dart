import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/entities/character_status.dart';
import 'package:rick_and_morty_app/src/routes/routes.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({
    super.key,
    required this.apiProvider,
    required this.scrollController,
    required this.isLoading,
  });

  final CharacterStatus apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    const characterStatus = {'Dead': 'Muerto', 'Alive': 'Vivo'};
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.80,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: isLoading
          ? apiProvider.characters.length + 2
          : apiProvider.characters.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < apiProvider.characters.length) {
          final character = apiProvider.characters[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.CHARACTER_DETAIL,
                  arguments: character);
            },
            child: Card(
              color: character.status == 'Dead' ? Colors.red : Colors.blue[800],
              child: Column(
                children: [
                  Hero(
                    tag: character.id!,
                    child: FadeInImage(
                      placeholder: const AssetImage(
                        'assets/images/portal-rick-and-morty.gif',
                      ),
                      image: NetworkImage(character.image!),
                    ),
                  ),
                  Text(
                    character.name!,
                    style: const TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                      'Estado: ${characterStatus[character.status] ?? 'Desconocido'}'),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
