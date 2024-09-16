import 'package:cint/pages/apresentacao/apresentacao4.dart';
import 'package:cint/pages/apresentacao/apresentacao5.dart';
import 'package:cint/pages/apresentacao/apresentacaopage.dart';
import 'package:cint/pages/apresentacao/apresentacao1.dart';
import 'package:cint/pages/apresentacao/apresentacao2.dart';
import 'package:cint/pages/apresentacao/apresentacao3.dart';
import 'package:cint/pages/desempenho.page.dart';
import 'package:cint/pages/doacao/comprovante.dart';
import 'package:cint/pages/doacao/inicio.dart';
import 'package:cint/pages/doar_necessidade.page.dart';
import 'package:cint/pages/home.page.dart';
import 'package:cint/pages/login_dev.page.dart';
import 'package:cint/pages/meta_batida.page.dart';
import 'package:cint/pages/ong.page.dart';
import 'package:cint/pages/ongsmap.page.dart';
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
      Apresentacao4.routeName: (context) => const Apresentacao4(),
      Apresentacao5.routeName: (context) => const Apresentacao5(),
      MinhasOfertas.routeName: (context) => const MinhasOfertas(),
      NovaOferta.routeName: (context) => const NovaOferta(),
      AnuncioForm.routeName: (context) => AnuncioForm(),
      EditarForm.routeName: (context) => const EditarForm(),
      ExplorarPage.routeName: (context) => const ExplorarPage(),
      LoginDevPage.routeName: (context) => const LoginDevPage(),
      OngPage.routeName: (context) => const OngPage(),
      OngsMap.routeName: (context) => const OngsMap(),
      Desempenho.routeName: (context) => const Desempenho(),
      MetaBatida.routeName: (context) => const MetaBatida(),
      NecessidadeForm.routeName: (context) => const NecessidadeForm(),
      DoarInicio.routeName: (context) => const DoarInicio(),
      Comprovante.routeName: (context) => const Comprovante(),
    };
