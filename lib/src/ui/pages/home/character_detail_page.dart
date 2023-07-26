import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/models/character_model.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_app_bar.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;
    final name = character.name ?? 'Sin nimbre';
    const textStyleSkins =
        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: CustomAppBar(title: name),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: Hero(
                tag: character.id!,
                child: Image.network(
                  character.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: size.height * 0.54,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Especie: ${character.species}',
                    style: textStyleSkins,
                  ),
                  Text(
                    'Genero: ${character.gender}',
                    style: textStyleSkins,
                  ),
                  Text(
                    'Fecha creacion: ${character.created}',
                    style: textStyleSkins.copyWith(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
