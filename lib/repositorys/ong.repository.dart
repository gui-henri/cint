import 'package:supabase_flutter/supabase_flutter.dart';

class OngRepository {
  Future<List<Map<String, dynamic>>> getAllWithPhotos() async {
    final response = await Supabase.instance.client
                            .from('instituicao')
                            .select('id, nome, foto_instituicao (url)');
    return response;
  }
}