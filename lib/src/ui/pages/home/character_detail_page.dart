import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rick_and_morty_app/src/models/character_model.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_app_bar.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/property_text.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({super.key});

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  PaletteGenerator? _paletteGenerator;
  bool disposeWidget = false;

  Future<void> _updatePaletteGenerator(String imagePath) async {
    final imageProvider = NetworkImage(imagePath);
    _paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    if (!disposeWidget) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    disposeWidget = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;
    _updatePaletteGenerator(character.image!);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(title: '', searchIconVisible: false),
      extendBodyBehindAppBar: true,
      backgroundColor:
          _paletteGenerator?.dominantColor?.color ?? Colors.transparent,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.primary,
                        width: 10,
                      ), // Color y ancho del borde
                    ),
                    margin: const EdgeInsets.only(top: 40),
                    height: size.height * 0.35,
                    width: double.infinity,
                    child: Hero(
                      tag: character.id!,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          character.image!,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colors.background.withOpacity(0.6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      character.name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colors.background.withOpacity(.4),
                ),
                padding: const EdgeInsets.all(10),
                height: size.height * 0.40,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PropertyText(
                      nameProperty: 'Status: ',
                      property: character.status!,
                      colorNameProperty: colors.primary,
                      colorProperty: colors.secondary,
                    ),
                    PropertyText(
                      nameProperty: 'Spepcies: ',
                      property: character.species!,
                      colorNameProperty: colors.primary,
                      colorProperty: colors.secondary,
                    ),
                    PropertyText(
                      nameProperty: 'Gender: ',
                      property: character.gender!,
                      colorNameProperty: colors.primary,
                      colorProperty: colors.secondary,
                    ),
                    PropertyText(
                      nameProperty: 'Origen: ',
                      property: character.origin?.name ?? 'N/A',
                      colorNameProperty: colors.primary,
                      colorProperty: colors.secondary,
                    ),
                    PropertyText(
                      nameProperty: 'Location: ',
                      property: character.location?.name ?? 'N/A',
                      colorNameProperty: colors.primary,
                      colorProperty: colors.secondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
