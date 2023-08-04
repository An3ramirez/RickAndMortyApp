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
              color: character.status == 'Dead'
                  ? Colors.red
                  : const Color(0xFF8400FF),
              child: Column(
                children: [
                  Hero(
                    tag: character.id!,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: FadeInImage(
                            placeholder: const AssetImage(
                              'assets/images/portal-rick-and-morty.gif',
                            ),
                            image: NetworkImage(character.image!),
                          ),
                        ),
                        if (character.status == 'Dead')
                          Positioned(
                            top: 15,
                            right: -20,
                            child: Transform.rotate(
                              angle: 45 * 3.141592653589793 / 180,
                              child: Material(
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  color: Colors.red,
                                  child: const Text(
                                    'Dead',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
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
          return Center(
            child: apiProvider.hasMoreItems
                ? const CircularProgressIndicator()
                : const Text(
                    'No hay mas información',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          );
        }
      },
    );
  }
}
