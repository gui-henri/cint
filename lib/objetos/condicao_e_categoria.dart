import 'dart:ffi';

import 'package:cint/repositorys/anuncios.repository.dart';
import 'package:cint/repositorys/ong.repository.dart';

class Condicao {
  final int id;
  final String condicao;

  Condicao({
    required this.id,
    required this.condicao,
  });

  // Construtor para criar uma instância de Condicao a partir de um JSON
  factory Condicao.fromJson(Map<String, dynamic> json) {
    return Condicao(
      id: json['id'],
      condicao: json['condicao'],
    );
  }

   // Método para converter uma instância de Condicao de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      id.toString(): id,
      condicao: condicao,
    };
  }
}


class ListaCondicoes {
  ListaCondicoes._privateConstructor();
  static final ListaCondicoes _instance = ListaCondicoes._privateConstructor();
  factory ListaCondicoes() {
    return _instance;
  }

  final AnunciosRepository _anunciosRepository = AnunciosRepository();
  List<Condicao> condicoesInstancias = [];
  List<String> listaCondicoes = [];

  Future<void> loadCondicoes() async {
    condicoesInstancias = await _anunciosRepository.getCondicoes();
    for (var instancia in condicoesInstancias) {
      listaCondicoes.add(instancia.condicao);
    }
  }
}
