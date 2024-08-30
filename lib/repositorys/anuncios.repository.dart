import 'package:cint/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnunciosRepository {
  Future<String> createPost(nome, quantidade, condicao, categoria, telefone, informacaoRelevante, textoAnuncio,  fotos) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .insert([{'nome_produto' : '$nome', 
                            'quantidade' : '$quantidade', 
                            'condicao' : '$condicao', 
                            'categoria' : '$categoria', 
                            'telefone' : '$telefone',
                            'informacao_relevante' : '$informacaoRelevante',
                            'texto_anuncio' : '$textoAnuncio',
                            //'tipo_id' : '$tipoId',
                            'fotos' : '$fotos',
                            'user_email': '${supabase.auth.currentSession?.user.email}'}])
                            .select('id')
                            .single();
    return response['id'].toString();
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


/* Future<List<String>> listFileUrls(String folderId) async {
  final supabase = Supabase.instance.client;

  try {
    // Listar arquivos dentro da pasta
    final response = await supabase.storage.from('anuncio').list(path: folderId);

    final List<String> fileUrls = [];

    // Gerar URL pública para cada arquivo
    for (var file in response) {
      final fileName = file.name;
      final fileResponse = await supabase.storage.from('anuncio').getPublicUrl('$folderId/$fileName');

      fileUrls.add(fileResponse);
    }

    return fileUrls;
  } catch (e) {
    print('Erro ao listar arquivos ou gerar URLs: $e');
    return [];
  }
} */

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
}

class UserRepository {

}


/* import 'package:cint/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/post_oferta.dart';

class AnunciosRepository {
  Future<PostOferta> createPost(nome, quantidade, condicao, categoria) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .insert([{'nome_produto' : '$nome', 'quantidade' : '$quantidade', 'condicao' : '$condicao', 'categoria' : '$categoria', 'user_email': '${supabase.auth.currentSession?.user.email}'}])
                            .select('id')
                            .single();
    final dadosPost = PostOferta(response['nome_produto'], response['quantidade'], response['condicao'], response['categoria'], response['id'].toString());
    
    return dadosPost;
  }

  Future<List<Map<String, dynamic>>> getPostInfo() async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .select('id, nome_produto, quantidade, condicao, categoria, telefone, informacao_relevante, texto_anuncio')
                            .eq('user_email', supabase.auth.currentSession?.user.email as Object);
    return response;
  }

  getUserEmail() {
    final response = supabase.auth.currentSession?.user.email;
    return response;
  }

  Future<List<Map<String, dynamic>>> addTextoAndTipo(id, texto) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .update({'texto_anuncio' : '$texto'})
                            .eq('id', id);
    return response;
  }
  
}

class UserRepository {

} */