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
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo-1.png'),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/home');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFF28730E)
                      ),
                    child: const Text('Try Login with Google', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                ),
              ],
            ),
          );
  }
}
