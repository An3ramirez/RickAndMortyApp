import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/routes/routes.dart';

class CustomDrawerMenu extends ConsumerStatefulWidget {
  const CustomDrawerMenu({super.key});

  @override
  CustomDrawerMenuState createState() => CustomDrawerMenuState();
}

class CustomDrawerMenuState extends ConsumerState<CustomDrawerMenu> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.read(selectedIndexProvider.notifier);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Rick And Morty'),
          ),
          ListTile(
            title: const Text('Personajes'),
            selected: selectedIndex.state == 0,
            onTap: () {
              selectedIndex.state = 0;
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.HOME,
                (_) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Ubicaciones'),
            selected: selectedIndex.state == 1,
            onTap: () {
              selectedIndex.state = 1;
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.LOCATION,
                (_) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Episodios'),
            selected: selectedIndex.state == 2,
            onTap: () {
              selectedIndex.state = 2;
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.EPISODE,
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

final selectedIndexProvider = StateProvider<int>((ref) => 0);
