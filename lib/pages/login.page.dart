import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  static const routeName = '/';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      Navigator.of(context).pushNamed('/home');
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
