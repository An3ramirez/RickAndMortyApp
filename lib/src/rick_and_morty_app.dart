import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/app_theme.dart';
import 'package:rick_and_morty_app/src/providers/theme_provider.dart';
import 'package:rick_and_morty_app/src/routes/pages.dart';

class RickAndMortyApp extends ConsumerWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick And Morty App',
      theme: AppTheme(selectedColor: 0).theme(brightness: themeModeState),
      initialRoute: Pages.INITIAL,
      routes: Pages.routes,
    );
  }
}
