import 'package:supabase_flutter/supabase_flutter.dart';

class OngRepository {
  Future<List<Map<String, dynamic>>> getAllWithPhotos() async {
    final response = await Supabase.instance.client
                            .from('instituicao')
                            .select('id, nome, foto_instituicao (url), descricao, id_categoria');
    return response;
  }
  Future<List<Map<String, dynamic>>> getCategoria() async {
    final response = await Supabase.instance.client
                            .from('preferencia')
                            .select('id, nome, instituicao(id, nome, foto_instituicao (url), descricao, id_categoria)')
                            .order('id', ascending: true);
    return response;
  }
}