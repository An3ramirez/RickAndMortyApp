import 'package:flutter/material.dart';

class CustomMessageBackground extends StatelessWidget {
  final String message;
  const CustomMessageBackground({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Opacity(
          opacity: 0.20,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ),
      ),
    );
  }
}
