import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/entities/location_status.dart';
import 'package:rick_and_morty_app/src/routes/routes.dart';

class LocationList extends StatelessWidget {
  const LocationList({
    super.key,
    required this.locationProvider,
    required this.scrollController,
    required this.isLoading,
  });

  final LocationStatus locationProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: isLoading
          ? locationProvider.locations.length + 1
          : locationProvider.locations.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < locationProvider.locations.length) {
          final location = locationProvider.locations[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.LOCATION_DETAIL,
                  arguments: location);
            },
            child: ListTile(
              title: Text('${index + 1} - ${location.name}'),
              subtitle: Text('Tipo: ${location.type}'),
            ),
          );
        } else {
          return Center(
            child: locationProvider.hasMoreItems
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
