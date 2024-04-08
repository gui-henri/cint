import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Login(title: 'Flutter Demo Home Page'),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        child: const Center(child: LoginBox()),
      ),
    );
  }
}

class LoginBox extends StatefulWidget {
  const LoginBox({super.key});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  bool buttonclicked = false;
  @override
  Widget build(BuildContext context) {
    return (!buttonclicked)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo-1.png'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttonclicked = true;
                      });
                    },
                    child: const Text('Try Login with Google'))
              ],
            ),
          )
        : Container(
            color: Colors.white,
            height: 100,
            width: 80,
          );
  }
}
