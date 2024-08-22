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

}