import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF28730E),
          title: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.black, fontSize: 11),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Buscar necessidade ou Instituição',
              hintStyle: TextStyle(color: Colors.black54),
              prefixIcon: Icon(Icons.search, color: Colors.black, size: 15,),
              border: OutlineInputBorder(
                gapPadding: 10,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide.none
              ),
              // Defina o preenchimento interno do TextField
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
              
            ),
          ),

          actions: const <Widget>[
            ],
            
          leadingWidth: 100.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
              child: Center(
                child: Image.asset('assets/images/logo-1.png'),
              ),
            ),
          
        ),
       
        body: const Center(
          child: Text("Hello, World!"),
        ),
      );
  }
}