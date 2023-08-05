import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, Brightness?>((_) {
  return ThemeProvider();
});

class ThemeProvider extends StateNotifier<Brightness?> {
  ThemeProvider() : super(Brightness.dark);
  void changeTheme(bool isOn) {
    state = isOn ? Brightness.dark : Brightness.light;
  }
}
