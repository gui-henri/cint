import 'package:cint/pages/apresentacao/apresentacaopage.dart';
import 'package:cint/pages/apresentacao/apresentacao1.dart';
import 'package:cint/pages/apresentacao/apresentacao2.dart';
import 'package:cint/pages/apresentacao/apresentacao3.dart';
import 'package:cint/pages/home.page.dart';
import 'package:cint/pages/login_dev.page.dart';
import 'package:cint/pages/perfil.page.dart';
import 'package:cint/pages/posts/anuncio_form.dart';
import 'package:cint/pages/posts/minhas_ofertas.dart';
import 'package:flutter/material.dart';
import 'package:cint/pages/login.page.dart';
import 'package:cint/pages/posts/nova_oferta.dart';
import 'pages/explorar.page.dart';

import 'pages/posts/editar_form.dart';

Map<String, Widget Function(dynamic)> instanceRoutes(BuildContext context) => {
      LoginPage.routeName: (context) => const LoginPage(),
      HomePage.routeName: (context) => const HomePage(),
      PerfilPage.routeName: (contexto) => const PerfilPage(),
      ApresentacaoPage.routeName: (context) => const ApresentacaoPage(),
      Apresentacao1.routeName: (context) => const Apresentacao1(),
      Apresentacao2.routeName: (context) => const Apresentacao2(),
      Apresentacao3.routeName: (context) => const Apresentacao3(),
      MinhasOfertas.routeName: (context) => const MinhasOfertas(),
      NovaOferta.routeName: (context) => const NovaOferta(),
      AnuncioForm.routeName: (context) => AnuncioForm(),
      EditarForm.routeName: (context) => const EditarForm(),
      ExplorarPage.routeName: (context) => const ExplorarPage(),
      LoginDevPage.routeName: (context) => const LoginDevPage(),
    };
