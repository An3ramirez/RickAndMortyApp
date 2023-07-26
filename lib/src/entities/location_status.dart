import 'package:rick_and_morty_app/src/models/location_model.dart';

class LocationStatus {
  final List<Location> locations;
  final bool hasMoreItems;

  LocationStatus({
    this.locations = const [],
    this.hasMoreItems = true,
  });

  LocationStatus copyWith({List<Location>? locations, bool? hasMoreItems}) =>
      LocationStatus(
        locations: locations ?? this.locations,
        hasMoreItems: hasMoreItems ?? this.hasMoreItems,
      );
}
