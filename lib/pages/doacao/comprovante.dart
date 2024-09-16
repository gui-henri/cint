import 'dart:io';

import 'package:cint/pages/home.page.dart';
import 'package:cint/pages/ong.page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Comprovante extends StatefulWidget {
  const Comprovante({Key? key}) : super(key: key);

  static const routeName = '/comprovante';

  @override
  State<Comprovante> createState() => _ComprovanteState();
}

class _ComprovanteState extends State<Comprovante> {

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            style: ButtonStyle(
                shape: WidgetStateProperty.all(const CircleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.black,
              ),
            ))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const FractionallySizedBox(
            widthFactor: 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.volunteer_activism, color: Color(0xFF28730E)),
                SizedBox(width: 10),
                Text(
                  'Oferte',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    'Envie o comprovante de pagamento',
                    style: TextStyle(
                      color: Color(0xFF28730E),
                      fontSize: 24.0,
                    ),
                  ),
                  const Text(
                    'Gere um comprovante de pagamento e envie para a instituição. Após a confirmação, sua meta será atualizada.',
                    style: TextStyle(
                      color: Color(0xFF28730E),
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(
                              text: _image != null ? _image!.path : "Selecione uma imagem"
                          ),
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      textStyle: WidgetStateProperty.all<TextStyle>(
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFF28730E),
                      ),
                    ),
                    onPressed: () {
                      if (_image != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Comprovante enviado com sucesso! Sua meta será atualizada em breve.'),
                          ),
                        );
                        Navigator.pushNamed(context, HomePage.routeName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Selecione uma imagem!'),
                          ),
                        );
                      }
                    },
                    child: const Text('Enviar'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
}
