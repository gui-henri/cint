import 'package:flutter/material.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  final ValueChanged<String> atualizarBusca;
  final String textoSalvo;
  final bool showTextField;
  final String telaPesquisada;
  const Header({super.key, required this.atualizarBusca, this.textoSalvo = '', this.showTextField = false, this.telaPesquisada = '/explorar'});

  @override
  _HeaderState createState() => _HeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

class _HeaderState extends State<Header> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: const Color(0xFF28730E),
      title: 
      widget.showTextField ?
      TextField(
        controller: _searchController,
        onChanged: (input) {
          widget.atualizarBusca(input);
        },
        onSubmitted: (value) {
          Navigator.of(context).pushNamed(widget.telaPesquisada, arguments: value);
        },
        style: const TextStyle(color: Colors.black, fontSize: 12),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFFF6F4EB),
          hintText: 'Buscar Instituição',
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
      )
      
      :
      SizedBox(),
      leadingWidth: 95.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Center(
          child: Image.asset('assets/images/logo-1.png'),
        ),
      ),
    );
  }
}
