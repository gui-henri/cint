import 'dart:io';

import 'package:cint/pages/apresentacao/apresentacao1.dart';
import 'package:cint/pages/apresentacao/apresentacaopage.dart';
import 'package:cint/pages/login_dev.page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cint/main.dart';
import 'package:cint/pages/perfil.page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
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
