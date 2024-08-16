import 'package:flutter/material.dart';

class OngButton extends StatelessWidget {

  const OngButton({super.key, required this.nomeOng, required this.imgOng, required this.navegar});

  final String nomeOng;
  final String imgOng;
  final String navegar;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(navegar);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(imgOng),
                    fit: BoxFit.fill, 
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                      child: Text(
                        nomeOng,
                        style: const TextStyle(
                          color: Color(0xFF28730E),
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
  }
}