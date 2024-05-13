import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65.0);

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    return AppBar(
      elevation: 1,
      backgroundColor: const Color(0xFF28730E),
      title: TextField(
        controller: _searchController,
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
