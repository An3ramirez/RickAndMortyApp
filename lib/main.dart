import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/rick_and_morty_app.dart';

void main() {
  runApp(const ProviderScope(child: RickAndMortyApp()));
}
