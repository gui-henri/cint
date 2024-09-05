import 'package:cint/components/post_oferta.dart';
import 'package:cint/repositorys/anuncios.repository.dart';

class ListaMinhasOfertas {
  ListaMinhasOfertas._privateConstructor();
  static final ListaMinhasOfertas _instance = ListaMinhasOfertas._privateConstructor();
  factory ListaMinhasOfertas() {
    return _instance;
  }

  final AnunciosRepository _anuncioRepository = AnunciosRepository();
  List<PostOferta> anunciosInstancias = [];

  Future<void> loadPosts() async {
    anunciosInstancias = await _anuncioRepository.gerarPosts();
  }
}