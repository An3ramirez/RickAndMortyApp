import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/routes/pages.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick And Morty App',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      initialRoute: Pages.INITIAL,
      routes: Pages.routes,
    );
  }
}
