

import 'package:cint/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {

  getUsers() async {
    final emails = await Supabase.instance.client
                          .from('usuario')
                          .select('user_email');
    return emails;
  }

  criarUser(data) async {
    await Supabase.instance.client
            .from('usuario')
            .insert([data]);
  }

/*   getAuthUsers() async {
    final users = await supabase.auth.
                          .from('users')
                          .select();
    return users;
  } */
}