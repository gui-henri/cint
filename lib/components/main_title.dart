import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {

  const MainTitle({super.key, required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}