import 'package:flutter/material.dart';
import '../pages/explorar.page.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  final ValueChanged<String> atualizarBusca;
  late final String textoSalvo;
  Header({Key? key, required this.atualizarBusca, this.textoSalvo = ''})
      : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

class _HeaderState extends State<Header> {
  final TextEditingController _searchController = TextEditingController();
  List<DadosOng> resultados = [];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: const Color(0xFF28730E),
      title: TextField(
        controller: _searchController,
        onChanged: (input) {
          widget.atualizarBusca(input);
          pesquisarOng(input);
        },
        onSubmitted: (value) {
          //widget.atualizarBusca(value);
          Navigator.of(context).pushNamed('/explorar', arguments: value);
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

  void pesquisarOng(String input) {
    if (input.isEmpty) {
      setState(() {
        resultados = listaOngs;
      });
    } else {
      setState(() {
        resultados = listaOngs
            .where(
                (ong) => ong.nome.toLowerCase().contains(input.toLowerCase()))
            .toList();
      });
    }
  }
}
