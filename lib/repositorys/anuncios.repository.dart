import 'package:cint/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnunciosRepository {
  Future<String> createPost(nome, quantidade, condicao, categoria, fotos) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .insert([{'nome_produto' : '$nome', 'quantidade' : '$quantidade', 'condicao' : '$condicao', 'categoria' : '$categoria', 'fotos' : '$fotos','user_email': '${supabase.auth.currentSession?.user.email}'}])
                            .select('id')
                            .single();
    return response['id'].toString();
  }

  Future<String> updateForm(id, nome, quantidade, condicao, categoria, fotos) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .update({'nome_produto' : '$nome', 'quantidade' : '$quantidade', 'condicao' : '$condicao', 'categoria' : '$categoria', 'fotos' : '$fotos', 'user_email': '${supabase.auth.currentSession?.user.email}'})
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

  Future<List<Map<String, dynamic>>> deletePost(id) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .delete()
                            .eq('id', id);
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