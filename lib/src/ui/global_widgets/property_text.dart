import 'package:flutter/material.dart';

class PropertyText extends StatelessWidget {
  final String nameProperty, property;
  final Color colorNameProperty, colorProperty;

  const PropertyText({
    super.key,
    required this.nameProperty,
    required this.property,
    required this.colorNameProperty,
    required this.colorProperty,
  });

  @override
  Widget build(BuildContext context) {
    const textStyleSkins =
        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: nameProperty,
            style: textStyleSkins.copyWith(color: colorNameProperty),
          ),
          TextSpan(
            text: property,
            style: textStyleSkins.copyWith(color: colorProperty),
          )
        ]),
      ),
    );
  }
}
