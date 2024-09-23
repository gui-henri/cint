import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF28730E),
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/explorar');
            },
            child: const Icon(
              Icons.explore_outlined,
              color: Colors.white,
              size: 38,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/favoritas');
            },
            child: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 38,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/home');
            },
            child: const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 38,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/home');
            },
            child: const Icon(
              Icons.chat_outlined,
              color: Colors.white,
              size: 38,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/perfil');
            },
            child: const Icon(
              Icons.person_outline_outlined,
              color: Colors.white,
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}
