import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/entities/location_status.dart';
import 'package:rick_and_morty_app/src/service/api_rick_and_morty.dart';

class LocationNotifier extends StateNotifier<LocationStatus> {
  final ApiRickAndMorty _apiProvider;

  LocationNotifier(this._apiProvider) : super(LocationStatus());

  Future<void> getLocations(int page) async {
    var locations = await _apiProvider.getLocations(page);
    var hasMoreItems = locations.length < 20;
    // Combinar las ubicaciones anteriores con las nuevas
    var combinedLocations = [...state.locations, ...locations];
    state = state.copyWith(
        locations: combinedLocations, hasMoreItems: !hasMoreItems);
  }
}

final StateNotifierProvider<LocationNotifier, LocationStatus>
    locationStateProvider = StateNotifierProvider((ref) {
  var apiService = ref.watch(apiProvider);
  return LocationNotifier(apiService);
});
