import 'package:cint/components/post_oferta.dart';
import 'package:cint/objetos/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/footer.dart';
import '../../components/header.dart';
import '../../components/title_back.dart';
import '../../main.dart';
import '../../repositorys/anuncios.repository.dart';


import 'salvos/lista_meus_posts.dart';

class MinhasOfertas extends StatefulWidget {
  const MinhasOfertas({super.key});

  static const routeName = '/minhasofertas';

  @override
  State<MinhasOfertas> createState() => _MinhasOfertasState();
}

class _MinhasOfertasState extends State<MinhasOfertas> {
  final rep = AnunciosRepository();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: Header(
        atualizarBusca: (value) {},
      ),
      bottomNavigationBar: const Footer(),
      body: Container(
          color: const Color(0xFFF6F4EB),
          child: Stack(children: [
                            titleBack(context, 'Minhas Ofertas', '/home', null),
                            Container(
                              padding: const EdgeInsets.only(top: 70),
                              child: ListaMeusPosts(),
                            )
                          ]),),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/anuncio_form', arguments: [false, null, null]);
          },
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF6EB855),
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
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
