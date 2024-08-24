import 'package:cint/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnunciosRepository {
  Future<String> createPost(nome, quantidade, condicao, categoria) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .insert([{'nome_produto' : '$nome', 'quantidade' : '$quantidade', 'condicao' : '$condicao', 'categoria' : '$categoria', 'user_email': '${supabase.auth.currentSession?.user.email}'}])
                            .select('id')
                            .single();
    return response['id'].toString();
  }

  Future<List<Map<String, dynamic>>> getPostInfo(String coluna, obj) async {
    final response = await Supabase.instance.client
                            .from('anuncio')
                            .select('id, nome_produto, quantidade, condicao, categoria, telefone, informacao_relevante, texto_anuncio')
                            .eq(coluna, obj as Object);
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