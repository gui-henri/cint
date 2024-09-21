import 'package:cint/components/post_oferta.dart';
import 'package:cint/main.dart';
import 'package:cint/objetos/condicao_e_categoria.dart';
import 'package:cint/objetos/posts.dart';
import 'package:cint/objetos/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnunciosRepository {

  criarPost(data) async {
    await Supabase.instance.client
            .from('anuncio')
            .insert([data]);
  }

updatePost(id, PostOferta postOferta) async {
  await Supabase.instance.client
      .from('anuncio')
      .update(postOferta.toJson())  // Utiliza o método toJson()
      .eq('id', id);
}


  Future<List<Map<String, dynamic>>> getPosts() async {
    final ongs = await Supabase.instance.client
                        .from('anuncio')
                        .select('id, nome_produto, quantidade, condicao, categoria, telefone, informacao_relevante, fotos, tipo_id, texto_anuncio, usuario')
                        .eq('usuario', Usuario().id);
    return ongs;
  }

  Future<List<PostOferta>> gerarPosts() async {
    List<PostOferta> lista = [];
    final get = await getPosts();
    for (var post in get) {
      lista.add(PostOferta.fromJson(post));
    }
    return lista;
  }

  Future<String> updateForm(id, nome, quantidade, condicao, categoria, telefone, informacaoRelevante, fotos) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .update({'nome_produto' : '$nome',
                            'quantidade' : '$quantidade', 
                            'condicao' : '$condicao', 
                            'categoria' : '$categoria', 
                            'telefone' : '$telefone',
                            'informacao_relevante' : '$informacaoRelevante',
                            'fotos' : '$fotos',
                            'user_email': '${supabase.auth.currentSession?.user.email}'})
                            .eq('id', id)
                            .select('id')
                            .single();
    return response['id'].toString();
  }

  Future<List<Map<String, dynamic>>> getPostInfo(String coluna, obj) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .select('id, nome_produto, quantidade, condicao, categoria, telefone, informacao_relevante, texto_anuncio, tipo_id, fotos')
                            .eq(coluna, obj as Object);
    return response;
  }

  getUserEmail() {
    final response = supabase.auth.currentSession?.user.email;
    return response;
  }

  Future<List<Map<String, dynamic>>> addTextoAndTipo(id, texto, tipo) async {
    final tipoId = await Supabase.instance.client
                            .from('preferencia')
                            .select('id')
                            .eq('nome', tipo);
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .update({'texto_anuncio' : '$texto', 'tipo_id' : tipoId[0]['id']})
                            .eq('id', id);
    return response;
  }

  Future<void> deletePost(id) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .delete()
                            .eq('id', id);
    return response;
  }

  String extractLastSegmentFromUrl(String url) {
    // Cria um objeto Uri a partir da URL
    final uri = Uri.parse(url);

    // Obtém os segmentos do caminho
    final pathSegments = uri.pathSegments;

    // Retorna o último segmento, se existir
    if (pathSegments.isNotEmpty) {
      return pathSegments.last;
    } else {
      throw Exception('URL não contém segmentos de caminho.');
    }
  }

  Future deleteFoto(url) async {
    final idFoto = extractLastSegmentFromUrl(url);
    print('idFoto: $idFoto');
    final response = await supabase.storage.from('anuncio').remove(['${supabase.auth.currentUser!.id}/$idFoto']);
    return response;
  }

  getCondicoes() async {
    List<Condicao> lista = [];
    final condicoes = await Supabase.instance.client
                            .from('condicoes_produto')
                            .select('id, condicao');
    print('aaaaaaakkkkkkk: $condicoes');
    for (var condicao in condicoes) {
      lista.add(Condicao.fromJson(condicao));
      print('cocndicoes: ${condicao['condicao']}');
    }
    return lista;
  }
}