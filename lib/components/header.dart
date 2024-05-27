import 'package:flutter/material.dart';
import '../pages/explorar.page.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController _searchController = TextEditingController();
  Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65.0);

  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)!.settings.name!;
    void pesquisarOng(String input) {
      List<DadosOng> resultados = [];
      if (input.isEmpty) {
        resultados = listaOngs;
      } else {
        resultados = listaOngs
            .where(
                (ong) => ong.nome.toLowerCase().contains(input.toLowerCase()))
            .toList();
      }
      Navigator.pushNamed(context, '/explorar', arguments: resultados);
    }

    return AppBar(
      elevation: 1,
      backgroundColor: const Color(0xFF28730E),
      title: TextField(
        controller: _searchController,
        onChanged: (value) {
          pesquisarOng(_searchController.text);
        },
        style: const TextStyle(color: Colors.black, fontSize: 12),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFFF6F4EB),
          hintText: 'Buscar necessidade ou Instituição',
          hintStyle: TextStyle(color: Colors.black54),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 28,
          ),
          border: OutlineInputBorder(
              gapPadding: 5,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        ),
      ),
      leadingWidth: 95.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Center(
          child: Image.asset('assets/images/logo-1.png'),
        ),
      ),
    );
  }
}
