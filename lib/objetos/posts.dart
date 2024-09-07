/* import 'package:cint/components/post_oferta.dart';
import 'package:cint/repositorys/anuncios.repository.dart';

class ListaMinhasOfertas {
  // Variáveis estáticas para compartilhar o estado entre todas as instâncias
  static final AnunciosRepository _anuncioRepository = AnunciosRepository();
  static List<PostOferta> _anunciosInstancias = [];

  // Construtor padrão
  ListaMinhasOfertas._();

  // Getter para acessar a lista de anúncios
  static List<PostOferta> get anunciosInstancias => _anunciosInstancias;

  // Método para carregar os posts
  static Future<void> loadPosts() async {
    _anunciosInstancias = await _anuncioRepository.gerarPosts();
  }
}
 */