import 'package:flutter/material.dart';

Widget CampoTexto(
    String label, bool obrigatorio, TextEditingController controller,
    {int size = 200, var keyboard = TextInputType.text}) {
  return Column(children: [
    Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF28730E),
          ),
        ),
        (obrigatorio)
            ? const Text(
                '*',
                style: TextStyle(color: Colors.red),
              )
            : const Text(''),
      ],
    ),
    TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: keyboard,
      maxLines: null,
      maxLength: size,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          if (obrigatorio == true) {
            return "* Campo obrigatório";
          }
        }
        return null;
      },
    ),
  ]);
}
