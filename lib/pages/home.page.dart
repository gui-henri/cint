import 'package:carousel_slider/carousel_slider.dart';
import 'package:cint/components/ong_carrossel.dart';
import 'package:cint/main.dart';
import 'package:cint/objetos/instituicao.dart';
import 'package:cint/repositorys/ong.repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/main_title.dart';
import '../components/ong_button.dart';
import '../components/header.dart';
import '../components/footer.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final rep = OngRepository(); 
  late Future<List<Map<String, dynamic>>> futureOngs;
  late SupabaseStreamBuilder streamONGs;
  final ongsInstancias = ListaInstituicoes().ongsInstancias;
  Set<Marker> markers = Set<Marker>();
  LatLng? _currentPosition;
    double? maisProxima;
    int? indexMaisProxima;
  @override
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    streamONGs = supabase.from('instituicao').stream(primaryKey: ['id']);
    futureOngs = rep.getAllWithPhotos();
    //ongsInstancias.clear();
  }

  Future<void> _getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      // Handle error
      print("Error getting location: $e");
    }
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return _askForLocationPermission();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return _askForLocationPermission();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return _askForLocationPermission();
    }

    _getCurrentPosition();
  }

  Future<void> _askForLocationPermission() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Location Permission'),
            content: const Text(
                'This app needs location permission to work properly.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: const Text('Close App'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Geolocator.openLocationSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          );
        });
  }

    Future<void> calcularDistanciaMaisProxima() async {
      for (var index = 0; index < ongsInstancias.length; index++) {
        var item = ongsInstancias[index];
        var coords = await rep.getCoordinates(item.endereco, dotenv.env['MAPS_KEY']);
        
        if (_currentPosition != null) {
          double distancia = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            coords[0],
            coords[1],
          );

          if (maisProxima == null || distancia < maisProxima!) {
            maisProxima = distancia;
            indexMaisProxima = index;
            
          }
        }
      }
    }

  @override

/*   @override
  void initState() {
    super.initState();
/*    _getCurrentPosition().then((position) {
      setState(() {
        _currentPosition = position;
      });
    }); */
    _checkLocationPermission();
    streamONGs = supabase.from('instituicao').stream(primaryKey: ['id']);
    futureOngs = rep.getAllWithPhotos();
    ongsInstancias.clear();
  }
  @override */
  
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

    // Executar a função para obter a ONG mais próxima
    FutureBuilder(
      future: calcularDistanciaMaisProxima(),
      builder: (context, _) {
        if (indexMaisProxima == null) {
          print('aa ${ongsInstancias}');
          return Center(child: CircularProgressIndicator());
        }
    print(ongsInstancias[indexMaisProxima!].nome);
    Random random = Random();
    final numRandom = 0 + random.nextInt((ongsInstancias.length - 1) - 0 + 1);
    //final numRandom =2;
    print('random: $numRandom');
    return FutureBuilder<List<double>>(
      future: rep.getCoordinates(ongsInstancias[indexMaisProxima!].endereco, dotenv.env['MAPS_KEY']),
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


                    // Atualizar os marcadores
                    markers.clear();
                    markers.add(
                      Marker(
                        markerId: MarkerId(ongsInstancias[numRandom].id),
                        position: LatLng(latitude, longitude),
                        infoWindow: InfoWindow(
                          title: ongsInstancias[numRandom].nome,
                          snippet: 'Endereço: ${ongsInstancias[numRandom].endereco}',
                        ),
                      ),
                    );

                    return Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 215,
                            width: 350,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(latitude, longitude),
                                zoom: 10,
                              ),
                              markers: markers, // Adiciona marcadores aqui
                              onMapCreated: (controller) {
                                // Se necessário, adicione mais configuração aqui
                              },
                            ),
                          ),
                        ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/ongsmap', arguments: [latitude, longitude, ongsInstancias[indexMaisProxima!]]),
              child: Container(
                height: 215,
                width: 350,
                color: Colors.transparent,
              ),
            ),
          ],
        );
      },
    );
  },
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
