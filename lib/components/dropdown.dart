import 'package:cint/objetos/condicao_e_categoria.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final List<String> listItems;
  final TextEditingController controller;
  final Function(String) onValueChanged;
  final String textoInicial;
  final String label;

  const DropDownWidget({super.key, required this.listItems, required this.controller, required this.onValueChanged, required this.textoInicial, required this.label});

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? selectedItem;
  

  @override
  void initState() {
    super.initState();
    // Definir o primeiro item como selecionado por padrão
    selectedItem = widget.controller.text.isNotEmpty ? widget.controller.text : widget.textoInicial;
    
  }

  @override
  Widget build(BuildContext context) {print('txtxxtt: ${widget.controller.text}');
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Color(0xFF28730E),
              ),
            ),
            const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(width: 1),
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
                widget.controller.text = selectedItem!;
                print('selectedItem: ${selectedItem}');
                widget.onValueChanged(selectedItem!);
              });
            },
            items: widget.listItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
