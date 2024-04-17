import 'package:cint/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:cint/pages/login.page.dart';

Map<String, Widget Function(dynamic)> instanceRoutes(BuildContext context) => {
      LoginPage.routeName: (context) => const LoginPage(),
      HomePage.routeName: (context) => const HomePage(),
    };