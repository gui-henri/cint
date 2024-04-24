import 'package:flutter/material.dart';

class Apresentacao1 extends StatefulWidget {
  const Apresentacao1({super.key});

  static const routeName = '/apresentacao1';

  @override
  State<Apresentacao1> createState() => _Apresentacao1State();
}

class _Apresentacao1State extends State<Apresentacao1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/apresentacao-1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 2,
            margin: const EdgeInsets.only(left: 40),
            child: Text(
              'Aqui você sabe exatamente as necessidades de cada instituição!',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.09,
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
