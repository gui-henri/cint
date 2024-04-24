import 'package:flutter/material.dart';

class Apresentacao3 extends StatefulWidget {
  const Apresentacao3({super.key});

  static const routeName = '/apresentacao3';

  @override
  State<Apresentacao3> createState() => _Apresentacao3State();
}

class _Apresentacao3State extends State<Apresentacao3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/apresentacao-3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.only(left: 30),
            child: const Text(
              'Pequenas boas ações fazem a diferença!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF28730E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
