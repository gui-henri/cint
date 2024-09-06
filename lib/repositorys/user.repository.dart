

import 'package:cint/main.dart';
import 'package:cint/objetos/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {

  getUsers() async {
    final emails = await Supabase.instance.client
                          .from('usuario')
                          .select('user_email');
    return emails;
  }

  getMyUser() async {
    final user = await Supabase.instance.client
                          .from('usuario')
                          .select()
                          .eq('user_email', '${supabase.auth.currentSession?.user.email}');
    return user;
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