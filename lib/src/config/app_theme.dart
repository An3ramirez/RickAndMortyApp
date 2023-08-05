import 'package:flutter/material.dart';

const Color _customColor = Color.fromARGB(255, 95, 9, 235);
const List<Color> _colorthemes = [
  _customColor,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  final int selectedColor;

  AppTheme({
    this.selectedColor = 0,
  }) : assert(selectedColor >= 0 && selectedColor < _colorthemes.length,
            'Colors must be between 0 and ${_colorthemes.length}');

  ThemeData theme({Brightness? brightness = Brightness.dark}) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorthemes[selectedColor],
      brightness: brightness,
    );
  }
}
