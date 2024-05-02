import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AnuncioForm extends StatefulWidget {
  const AnuncioForm({super.key});

  @override
  State<AnuncioForm> createState() => _AnuncioFormState();
}

class _AnuncioFormState extends State<AnuncioForm> {
  final _formKey = GlobalKey<FormState>();

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ))),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: FractionallySizedBox(
          widthFactor: 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset('assets/icons/icon-megaphone-solid.png'),
              Text(
                'Anuncie',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CampoTexto('Informe o produto a ser doado', true),
                    CampoTexto('Quantidade do produto', true),
                    CampoTexto('Condições do produto', true),
                    CampoTexto('Categoria do produto', true),
                    CampoTexto('Telefone para contato', false,
                        size: 11, keyboard: TextInputType.number),
                    CampoTexto(
                        'Há mais alguma informação relevante sobre o\nproduto que gostaria de compartilhar?',
                        false),
                  ],
                ),
              ),
            ),
            BotaoFoto(),
            SizedBox(
              height: 20,
            ),
            BotaoEnviar(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void enviarForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/home');
    }
  }

  Widget BotaoEnviar() {
    return TextButton(
      onPressed: () {
        enviarForm();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: BorderSide(
              width: 1,
              color: const Color(0xFF28730E),
            ),
          ),
        ),
      ),
      child: Container(
        width: 130,
        height: 30,
        child: Center(
          child: Text(
            'Enviar',
            style: TextStyle(
              color: const Color(0xFF28730E),
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget BotaoFoto() {
    return TextButton(
      child: Container(
        height: 37,
        width: 299,
        child: Center(
          child: Text('Anexar foto do produto'),
        ),
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        backgroundColor: MaterialStatePropertyAll(const Color(0xFF28730E)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
      onPressed: () {
        _pickImage();
      },
    );
  }
}

Widget CampoTexto(String label, bool obrigatorio,
    {int size = 200, var keyboard = TextInputType.text}) {
  return Column(children: [
    Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF28730E),
          ),
        ),
        (obrigatorio)
            ? Text(
                '*',
                style: TextStyle(color: Colors.red),
              )
            : Text(''),
      ],
    ),
    TextFormField(
      keyboardType: TextInputType.number,
      maxLines: null,
      maxLength: size,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
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
