import 'package:cint/pages/apresentacao/apresentacaopage.dart';
import 'package:cint/pages/apresentacao/apresentacao1.dart';
import 'package:cint/pages/apresentacao/apresentacao2.dart';
import 'package:cint/pages/apresentacao/apresentacao3.dart';
import 'package:cint/pages/home.page.dart';
import 'package:cint/pages/perfil.page.dart';
import 'package:flutter/material.dart';
import 'package:cint/pages/login.page.dart';

Map<String, Widget Function(dynamic)> instanceRoutes(BuildContext context) => {
      LoginPage.routeName: (context) => const LoginPage(),
      HomePage.routeName: (context) => const HomePage(),
      PerfilPage.routeName: (contexto) => const PerfilPage(),
      ApresentacaoPage.routeName: (context) => const ApresentacaoPage(),
      Apresentacao1.routeName: (context) => const Apresentacao1(),
      Apresentacao2.routeName: (context) => const Apresentacao2(),
      Apresentacao3.routeName: (context) => const Apresentacao3(),
    };
