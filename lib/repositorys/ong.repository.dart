import 'package:cint/objetos/instituicao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cint/main.dart';

class OngRepository {

  Future<List<Map<String, dynamic>>> getOneWithPhotos(String id) async {
    final response = await Supabase.instance.client
                            .from('instituicao')
                            .select('id, nome, foto_instituicao (url), foto, descricao, id_categoria, nota, endereco, pix')
                            .eq('id', id);
    return response;
  }

  Future<List<Map<String, dynamic>>> getNecessidades(String id) async {
    final response = await Supabase.instance.client
                            .from('necessidade')
                            .select('id, nome, descricao, urgente, instituicao_id')
                            .eq('instituicao_id', id);
    return response;
  }

  Future<List<Map<String, dynamic>>> getAllWithPhotos() async {
    final response = await Supabase.instance.client
                            .from('instituicao')
                            .select('id, nome, foto, endereco, descricao, id_categoria');
    return response;
  }
  Future<List<Map<String, dynamic>>> getCategoria() async {
    final response = await Supabase.instance.client
                            .from('preferencia')
                            .select('id, nome')
                            .order('id', ascending: true);
    return response;
  }

  //metodos para pegar coordenadas pelo endereço
Future<List<double>> getCoordinates(String address, apiKey) async {
  List<double> coordenadas = [];

  final formattedAddress = Uri.encodeComponent(address);
  print('fadress: $formattedAddress');
  print('APIkEY: $apiKey');
  final url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$formattedAddress&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Response Data: $data');  // Adicione esta linha para depuração
    if (data['status'] == 'OK') {
      final location = data['results'][0]['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];
      coordenadas.add(lat);
      coordenadas.add(lng);
      print('Latitude: $lat, Longitude: $lng');
    } else {
      print('Error: ${data['status']}');
    }
  } else {
    print('Failed to load data. Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');  // Adicione esta linha para depuração
  }

  return coordenadas;
}

  Future<List<Map<String, dynamic>>> getOngs() async {
    final ongs = await Supabase.instance.client
                        .from('instituicao')
                        .select('id, nome, nota, endereco, descricao, pix, missao, historia, meta, id_categoria, foto');
    return ongs;
  }

  gerarOngs() async {
    List<Instituicao> lista = [];
    final get = await getOngs();
    for (var ong in get) {
      lista.add(Instituicao.fromJson(ong));
    }
    return lista;
  }
}