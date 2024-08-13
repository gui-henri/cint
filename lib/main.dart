import 'package:cint/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vjenejdvtvletpfewufb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZqZW5lamR2dHZsZXRwZmV3dWZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI4Mjc5NzgsImV4cCI6MjAyODQwMzk3OH0.0kgGcARjWRbSu4qYxKPcY9kHAoaE8ZzK71psTwmw-8g',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

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
