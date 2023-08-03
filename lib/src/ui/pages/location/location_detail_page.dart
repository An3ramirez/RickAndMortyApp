import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/models/location_model.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_app_bar.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/property_text.dart';

class LocationDetailPage extends StatelessWidget {
  const LocationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Location location =
        ModalRoute.of(context)!.settings.arguments as Location;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(title: '', searchIconVisible: false),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEDD400),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              height: size.height * 0.15,
              width: size.width * 0.90,
              child: Center(
                child: Text(
                  location.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: colors.background,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEDD400)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              padding: const EdgeInsets.all(20),
              width: size.width * 0.90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PropertyText(
                    nameProperty: 'Type: ',
                    property: location.type,
                    colorNameProperty: colors.primary,
                    colorProperty: colors.secondary,
                  ),
                  PropertyText(
                    nameProperty: 'Dimension: ',
                    property: location.dimension,
                    colorNameProperty: colors.primary,
                    colorProperty: colors.secondary,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
