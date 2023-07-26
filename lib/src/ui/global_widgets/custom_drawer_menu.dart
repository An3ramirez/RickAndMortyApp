import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/routes/routes.dart';

class CustomDrawerMenu extends StatefulWidget {
  const CustomDrawerMenu({super.key});

  @override
  State<CustomDrawerMenu> createState() => _CustomDrawerMenuState();
}

class _CustomDrawerMenuState extends State<CustomDrawerMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            selected: _selectedIndex == 0,
            onTap: () {
              _onItemTapped(0);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.HOME,
                (_) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Ubicaciones'),
            selected: _selectedIndex == 1,
            onTap: () {
              _onItemTapped(1);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.LOCATION,
                (_) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Episodios'),
            selected: _selectedIndex == 2,
            onTap: () {
              // Update the state of the app
              _onItemTapped(2);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
