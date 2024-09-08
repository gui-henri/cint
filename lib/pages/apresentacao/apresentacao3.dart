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
            width: MediaQuery.of(context).size.width * 2,
            margin: const EdgeInsets.only(left: 40),
            child: Text(
              'Pequenas boas ações fazem a diferença!',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.09,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF28730E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
