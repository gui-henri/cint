import 'package:cint/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'C-int',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF28730E),
          textTheme: GoogleFonts.openSansTextTheme(),
        ),
        initialRoute: '/',
        routes: instanceRoutes(context));
  }
}
