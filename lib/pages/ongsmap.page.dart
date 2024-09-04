import 'dart:math';

import 'package:cint/components/ongs_detalhes.dart';
import 'package:cint/main.dart';
import 'package:cint/objetos/instituicao.dart';
import 'package:cint/repositorys/ong.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final appKey = GlobalKey();

class OngsMap extends StatefulWidget {
  const OngsMap({super.key});

  static const routeName = '/ongsmap';

  @override
  State<OngsMap> createState() => _OngsMapState();
}

class _OngsMapState extends State<OngsMap> {
  final rep = OngRepository(); 
  late Future<List<Map<String, dynamic>>> futureOngs;
  late SupabaseStreamBuilder streamONGs;
  List ongsInstancias = [];
  Set<Marker> markers = Set<Marker>();
  @override
  void initState() {
    super.initState();
    //ongsInstancias.clear();
    streamONGs = supabase.from('instituicao').stream(primaryKey: ['id']);
    _fetchOngs();
    futureOngs = rep.getAllWithPhotos();
    //_updateMarkers();
  }
  Future<void> _fetchOngs() async {
    final data = await supabase.from('instituicao').select();
    ongsInstancias = (data as List).map((item) => Instituicao.fromJson(item)).toList();
    
    setState(() {});
    print('oIInst: $ongsInstancias');
  }

  Future<void> _updateMarkers() async {
    markers.clear();
    ongsInstancias.forEach((ong) async {
      final coords = await rep.getCoordinates(ong.endereco, dotenv.env['MAPS_KEY']);
      final latitude = coords[0];
      final longitude = coords[1];

      markers.add(
        Marker(
          markerId: MarkerId(ong.id),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: ong.nome,
            snippet: 'Endereço: ${ong.endereco}',
          ),
          onTap: () => {
            showModalBottomSheet(context: appKey.currentState!.context, builder: (context) => OngsDetalhes(ong: ong),)
          }
        ),
      );

      
    });
    //setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    var latitude = args[0];
    var longitude = args[1];
    var ongInicial = args[2];
    
/*     if (ongsInstancias.isNotEmpty && markers.isEmpty) {
      _updateMarkers();
    } */
    _updateMarkers();
    print('markers!!!!! $markers');
    return Scaffold(
      key: appKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF28730E),
        
      ),
      body: StreamBuilder(
  stream: streamONGs,
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    final data = snapshot.data!;
    if (data.isEmpty) {
      return Center(child: Text('Nenhuma ONG encontrada.'));
    }

    ongsInstancias = data.map((item) => Instituicao.fromJson(item)).toList();
    for (var ong in data) {
      ongsInstancias.add(Instituicao.fromJson(ong));
    }

    if (ongsInstancias.isEmpty) {
      return Center(child: Text('Nenhuma instituição disponível.'));
    }

    return FutureBuilder<List<double>>(
      future: rep.getCoordinates(ongInicial.endereco, dotenv.env['MAPS_KEY']),
      builder: (context, coordinatesSnapshot) {
        if (!coordinatesSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final coordinates = coordinatesSnapshot.data!;
        if (coordinates.isEmpty) {
          return Center(child: Text('Coordenadas não encontradas.'));
        }

        final latitude = coordinates[0];
        final longitude = coordinates[1];


/*         // Atualizar os marcadores
        markers.clear();
        markers.add(
          Marker(
            markerId: MarkerId(ongsInstancias[currentIndex].id),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: ongsInstancias[currentIndex].nome,
              snippet: 'Endereço: ${ongsInstancias[currentIndex].endereco}',
            ),
          ),
        ); */

      return GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(latitude, longitude),
                                  zoom: 10,
                                ),
                                markers: markers, // Adiciona marcadores aqui
                               /*  onMapCreated: (controller) {
                                  // Se necessário, adicione mais configuração aqui
                                },  */
                              );
      });})
    );
  }
}