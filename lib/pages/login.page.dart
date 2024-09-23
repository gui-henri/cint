import 'dart:io';

import 'package:cint/objetos/user.dart';
import 'package:cint/pages/login_dev.page.dart';
import 'package:cint/repositorys/user.repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cint/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final repUser = UserRepository();
  String? _userId;
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _userId = data.session?.user.id;
      });
      if (_userId != null) {
        Navigator.pushNamed(context, '/ApresentacaoPage');
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    const webClientId =
        '880819740648-1fehn5cf9adsditbu33oanfnsfkqu3fh.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    var googleUser = await googleSignIn.signInSilently();
    googleUser ??= await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    final email = googleUser.email;
    print('Email do usuário: $email');
final AuthResponse response = await supabase.auth.signInWithIdToken(
  provider: OAuthProvider.google,
  idToken: idToken,
  accessToken: accessToken,
);

// Verifica se a autenticação foi bem-sucedida antes de acessar o usuário
if (response.session != null) {
  final user = supabase.auth.currentUser;
  final profileImageUrl = googleUser.photoUrl;
  final fullName = user?.userMetadata?['full_name'];
    
    //final authUsers = await repUser.getAuthUsers(email);
    final users = await repUser.getUsers();
    //print('!!!!!!!!!!userid: ${user.id}');
    bool contaJaExiste = false;
    for (var map in users) {
      if (map['user_email'] == email) {
        contaJaExiste = true;
      }
    }
    try {
      if (!contaJaExiste) {
        final usuarioLogado = Usuario(id: user!.id, nome: fullName, titulo: 0, nota: 0, meta: 0, endereco: '', foto: profileImageUrl, posts: [], email: email, favoritas: []);
        await repUser.criarUser(usuarioLogado.toJson());
      }
    } catch (e) {
      print('Erro ao criar usuário: $e');
    }
    try {
      if (contaJaExiste) {
        final usuarioLogadoJson = await repUser.getMyUser();
        print('usuariologado: $usuarioLogadoJson');
        // Atualiza o estado compartilhado do Usuario
        Usuario.fromJson(usuarioLogadoJson[0]);
          print('usuario: ${Usuario().email}'); 
      }
    } catch (e) {
      print('Erro ao carregar usuário: $e');
    }
} else {
  print('Erro na autenticação');
}

return response;



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF28730E),
            Color(0xFF6EB855),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo-1.png'),
                GestureDetector(
                  onTap: () async {
                    if (!kIsWeb && (Platform.isAndroid)) {
                      await _googleSignIn();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFF28730E)),
                    child: const Text('Try Login with Google',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginDevPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFF28730E)),
                    child: const Text('Login email e senha DEV',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
