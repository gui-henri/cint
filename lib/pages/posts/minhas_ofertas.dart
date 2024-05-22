import 'dart:js';

import 'package:flutter/material.dart';
import 'package:cint/routes.dart';
import 'package:flutter/widgets.dart';

import '../../components/footer.dart';
import '../../components/header.dart';
import '../../components/title_back.dart';
import 'anuncio_form.dart';

import '../../components/post_oferta.dart';

import 'salvos/lista_meus_posts.dart';

class MinhasOfertas extends StatefulWidget {
  const MinhasOfertas({super.key});

  static const routeName = '/minhasofertas';

  @override
  State<MinhasOfertas> createState() => _MinhasOfertasState();
}

class _MinhasOfertasState extends State<MinhasOfertas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      bottomNavigationBar: const Footer(),
      body: Container(
          color: const Color(0xFFF6F4EB),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 1,
            child: Stack(children: [
              titleBack(context, 'Minhas Ofertas', '/home'),
              (meusPosts.isEmpty)
                  ? Column(children: [
                      Container(
                        child: semOfertas(),
                        padding: EdgeInsets.only(top: 70),
                      ),
                    ])
                  : FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        child: ListaMeusPosts(),
                        padding: EdgeInsets.only(top: 70),
                      ),
                    ),
            ]),
          )),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnuncioForm()),
            );
          },
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF6EB855),
          child: Icon(Icons.add),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}

Widget semOfertas() {
  return const Padding(
    padding: EdgeInsets.all(30),
    child: Column(
      children: [
        Text(
          'Ainda não há ofertas!',
          style: TextStyle(
            color: Color(0xFF28730E),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Para ofertar um produto, é só preencher um formulário. Leva menos de 3 minutos!',
          style: TextStyle(color: Color(0xFF28730E)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
