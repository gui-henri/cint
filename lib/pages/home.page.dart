import 'package:carousel_slider/carousel_slider.dart';
import 'package:cint/components/ong_carrossel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import '../components/main_title.dart';
import '../components/ong_button.dart';
import '../components/header.dart';
import '../components/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        atualizarBusca: (value) {},
      ),
      bottomNavigationBar: const Footer(),

      body: Container(
        color: const Color(0xFFF6F4EB),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: const MainTitle(texto: 'Recomendadas'),
            ),
            const SizedBox(
              height: 15,
            ),
            const OngsCarousel(),
            const SizedBox(
              height: 60,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: const Row(
                children: [
                  MainTitle(texto: 'Perto de você'),
                  SizedBox(width: 0),
                  Icon(
                    Icons.location_on_sharp,
                    size: 35,
                    color: Color(0xFF28730E),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 215,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
                initialPage: 0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
              items: const [
                OngButton(
                  nomeOng: 'Esperança Renovada',
                  imgOng: 'assets/images/ongImg-1.png',
                  navegar: '/home',
                ),
                OngButton(
                  nomeOng: 'Mãos Solidárias',
                  imgOng: 'assets/images/ongImg-1.png',
                  navegar: '/home',
                ),
                OngButton(
                  nomeOng: 'Esperança Renovada',
                  imgOng: 'assets/images/ongImg-1.png',
                  navegar: '/home',
                ),
                OngButton(
                  nomeOng: 'Mãos Solidárias',
                  imgOng: 'assets/images/ongImg-1.png',
                  navegar: '/home',
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: SpeedDial(
        foregroundColor: Colors.white,
        buttonSize: const Size(60, 60),
        childrenButtonSize: const Size(60, 60),
        overlayOpacity: 0,
        spacing: 10,
        spaceBetweenChildren: 0,
        icon: Icons.widgets_outlined,
        activeIcon: Icons.close,
        backgroundColor: const Color(0xFF6EB855),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.post_add_outlined),
            label: 'Criar oferta',
            onTap: () => {
              Navigator.pushNamed(context, '/anuncio_form', arguments: [false, null, null])
            },
            shape: const CircleBorder(),
            labelStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
          SpeedDialChild(
            child: const Icon(Icons.receipt_long_outlined),
            label: 'Minhas ofertas',
            onTap: () => {Navigator.pushNamed(context, '/minhasofertas')},
            shape: const CircleBorder(),
            labelStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ));
  }
}
