import 'package:flutter/material.dart';

class Apresentacao2 extends StatefulWidget {
  const Apresentacao2({super.key});

  static const routeName = '/apresentacao2';

  @override
  State<Apresentacao2> createState() => _Apresentacao2State();
}

class _Apresentacao2State extends State<Apresentacao2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/apresentacao-2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 2,
            margin: const EdgeInsets.only(left: 40),
            child: Text(
              'Encontre ONG’s por recomendação personalizada e perto de você!',
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
