import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_app_bar.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_drawer_menu.dart';
import 'package:rick_and_morty_app/src/ui/pages/location/location_list.dart';
import 'package:rick_and_morty_app/src/ui/pages/location/location_state.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends ConsumerState<LocationPage> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final apiProvider = ref.read(locationStateProvider.notifier);
    apiProvider.getLocations(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        await apiProvider.getLocations(page);
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
    final locationProvider = ref.watch(locationStateProvider);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ubicaciones'),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: locationProvider.locations.isNotEmpty
            ? LocationList(
                scrollController: scrollController,
                isLoading: isLoading,
                locationProvider: locationProvider,
              )
            : const Center(child: CircularProgressIndicator()),
      ),
      drawer: const CustomDrawerMenu(),
    );
  }
}
