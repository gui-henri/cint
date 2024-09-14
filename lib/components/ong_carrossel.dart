import 'package:carousel_slider/carousel_slider.dart';
import 'package:cint/components/ong_button.dart';
import 'package:cint/objetos/instituicao.dart';
import 'package:cint/repositorys/ong.repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Importe o Supabase

class OngsCarousel extends StatefulWidget {
  const OngsCarousel({super.key});

  @override
  OngsCarouselState createState() => OngsCarouselState();
}

class OngsCarouselState extends State<OngsCarousel> {
  final rep = OngRepository();
  Future<List<Map<String, dynamic>>> futureOngs = Future.value([]);
  final ongsInstancias = ListaInstituicoes().ongsInstancias;

  List<String> userPreferences = [];
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
    futureOngs = rep.getAllWithPhotos();
  }

  Future<void> _loadUserPreferences() async {
    final user = supabase.auth.currentUser;
    
    if (user != null) {
      final response = await supabase
          .from('usuario_preferencia')
          .select('id_preferencia')
          .eq('id_usuario', user.id);

      if (response.isNotEmpty) {
        List<String> loadedPreferences = response.map<String>((pref) {
          return pref['id_preferencia']?.toString() ?? '';
        }).toList();
        
        setState(() {
          userPreferences = loadedPreferences.where((pref) => pref.isNotEmpty).toList(); 
          futureOngs = _loadOngsByPreferences();
        });
      }
    }
  }

  Future<List<Map<String, dynamic>>> _loadOngsByPreferences() async {
    final allOngs = await rep.getAllWithPhotos();
    
    return allOngs.where((ong) {
      final idCategoria = ong['id_categoria']?.toString();
      return idCategoria != null && userPreferences.contains(idCategoria);
    }).toList();
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
          items: ongs.map((ong) {
            final nomeOng = ong['nome']?.toString() ?? 'ONG sem nome';
            final imgOng = ong['foto']?.toString() ?? '';

            return OngButton(
              nomeOng: nomeOng,
              imgOng: imgOng,
              navegar: ong.id,
            );
          }).toList(),
        );
      },
    );
  }
}
