import 'package:cint/objetos/condicao_e_categoria.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final List<String> listItems;

  const DropDownWidget({super.key, required this.listItems});

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    // Definir o primeiro item como selecionado por padrão
    selectedItem = widget.listItems.isNotEmpty ? widget.listItems[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFF28730E), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(0, 5), // Posição da sombra
          ),
        ],
      ),
      child: DropdownButton<String>(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        value: selectedItem,
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: (String? newValue) {
          setState(() {
            selectedItem = newValue;
          });
        },
        items: widget.listItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
