import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon = Icons.arrow_forward_ios, // Ícone padrão
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              icon,
              size: 20.0,
              color: Colors.black,
            ),
          ],
        ),
      );
  }
}
