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



class Categoria {
  final int id;
  final String categoria;

  Categoria({
    required this.id,
    required this.categoria,
  });

  // Construtor para criar uma instância de Condicao a partir de um JSON
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      categoria: json['categoria'],
    );
  }

   // Método para converter uma instância de Condicao de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      id.toString(): id,
      categoria: categoria,
    };
  }
}


class ListaCategorias {
  ListaCategorias._privateConstructor();
  static final ListaCategorias _instance = ListaCategorias._privateConstructor();
  factory ListaCategorias() {
    return _instance;
  }

  final AnunciosRepository _anunciosRepository = AnunciosRepository();
  List<Categoria> categoriasInstancias = [];
  List<String> listaCategorias = [];

  Future<void> loadCategorias() async {
    categoriasInstancias = await _anunciosRepository.getCategorias();
    for (var instancia in categoriasInstancias) {
      listaCategorias.add(instancia.categoria);
    }
  }
}




