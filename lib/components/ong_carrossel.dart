import 'package:carousel_slider/carousel_slider.dart';
import 'package:cint/components/ong_button.dart';
import 'package:cint/objetos/instituicao.dart';
import 'package:cint/repositorys/ong.repository.dart';
import 'package:flutter/material.dart';

class OngsCarousel extends StatefulWidget {
  const OngsCarousel({super.key});

  @override
  OngsCarouselState createState() => OngsCarouselState();
}

class OngsCarouselState extends State<OngsCarousel> {
  final rep = OngRepository(); 
  late Future<List<Map<String, dynamic>>> futureOngs;
  final ongsInstancias = ListaInstituicoes().ongsInstancias;

  @override
  void initState() {
    super.initState();
    futureOngs = rep.getAllWithPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureOngs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar ONGs'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma ONG encontrada'));
        }

        final ongs = snapshot.data!;

        return CarouselSlider(
          options: CarouselOptions(
            height: 215,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
          ),
          items: ongsInstancias.map((ong) {
            return OngButton(
              nomeOng: ong.nome,
              imgOng: ong.foto,
              navegar: ong.id,
            );
          }).toList(),
        );
      },
    );
  }
}
